
Name:           easyrpg-player
Version:        0.6.2.3
Release:        1%{?dist}
Summary:        Game interpreter to play RPG Maker 2000, 2003 and EasyRPG games

Group:          Amusements/Games/RPG
License:        GPL-3.0
URL:            https://easyrpg.org
Source0:        https://easyrpg.org/downloads/player/%{version}/%{name}-%{version}.tar.xz

BuildRequires:  gcc-c++
BuildRequires:  libtool
BuildRequires:  pkgconfig
BuildRequires:  pkgconfig(liblcf)
BuildRequires:  pkgconfig(sdl2)
BuildRequires:  pkgconfig(SDL2_mixer)
BuildRequires:  pkgconfig(pixman-1)
BuildRequires:  pkgconfig(freetype2)
BuildRequires:  pkgconfig(harfbuzz)
BuildRequires:  pkgconfig(ogg)
BuildRequires:  pkgconfig(vorbisfile)
BuildRequires:  pkgconfig(opusfile)
BuildRequires:  pkgconfig(speexdsp)
BuildRequires:  pkgconfig(sndfile)
BuildRequires:  pkgconfig(libxmp)
BuildRequires:  pkgconfig(bash-completion)
BuildRequires:  pkgconfig(libpng16)
%if 0%{?fedora_version} >= 26 || ( 0%{?sle_version} >= 120300 && 0%{?is_opensuse} )
BuildRequires:  pkgconfig(libmpg123)
%endif
%if 0%{?suse_version} > 1500
# tumbleweed needs this
BuildRequires:  mpg123-devel
%endif
%if 0%{?suse_version}
BuildRequires:  libpng16-compat-devel
%endif

# currently not building source documentation
#BuildRequires:  doxygen

%description
EasyRPG Player is a program that allows to play games created with
RPG Maker 2000 and 2003. It aims to be a free (as in freedom)
cross-platform RPG Maker 2000/2003 interpreter. The main goal is
to play all games created with them as the original game interpreter
(RPG_RT.exe) does.

%prep
%setup -q
%ifarch ppc64le
# disable powerpc intrinsics in c++ mode
sed -i -e '/^AX_CXX_COMPILE_STDCXX/ s/noext/ext/' configure.ac
autoreconf -fi
%endif

%build
%configure --enable-fmmidi=fallback
make %{?_smp_mflags}

%install
%make_install

%files
%if 0%{?suse_version}
%doc COPYING
%else
%license COPYING
%endif
%doc README.md AUTHORS.md
%{_bindir}/*
%{_mandir}/man6/*
%{_datadir}/bash-completion/completions/*

%changelog
* Sun Dec 20 2020 carstene1ns <dev@ f4ke .de> - 0.6.2.3-1
- Upstream update

* Wed Jul 15 2020 carstene1ns <dev@ f4ke .de> - 0.6.2.1-1
- Upstream update

* Sat May 02 2020 carstene1ns <dev@ f4ke .de> - 0.6.2-2
- Enable mp3/opus/harfbuzz support

* Mon Apr 27 2020 carstene1ns <dev@ f4ke .de> - 0.6.2-1
- Upstream Update

* Thu Aug 29 2019 carstene1ns <dev@ f4ke .de> - 0.6.1-1
- Upstream Update

* Mon Mar 04 2019 carstene1ns <dev@ f4ke .de> - 0.6.0-1
- Upstream Update

* Sat Oct 27 2018 carstene1ns <dev@ f4ke .de> - 0.5.4-1
- Upstream Update

* Sun Oct 22 2017 carstene1ns <dev@ f4ke .de> - 0.5.3-1
- Upstream Update

* Wed Jun 28 2017 carstene1ns <dev@ f4ke .de> - 0.5.2-1
- Upstream Update

* Sun Apr 16 2017 carstene1ns <dev@ f4ke .de> - 0.5.1-1
- Upstream Update
- Patch mouse wheel code for older SuSE SDL version

* Sat Sep 24 2016 carstene1ns <dev@ f4ke .de> - 0.5.0-1
- Upstream Update

* Sun Mar 20 2016 carstene1ns <dev@ f4ke .de> - 0.4.1-2
- Checksum Update

* Sat Mar 19 2016 carstene1ns <dev@ f4ke .de> - 0.4.1-1
- Upstream Update

* Mon Jan 4 2016 carstene1ns <dev@ f4ke .de> - 0.4.0-1
- created package
