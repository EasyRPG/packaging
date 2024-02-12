
Name:           easyrpg-player
Version:        0.8
Release:        5%{?dist}
Summary:        Game interpreter to play RPG Maker 2000, 2003 and EasyRPG games

Group:          Amusements/Games/RPG
License:        GPL-3.0
URL:            https://easyrpg.org
Source0:        https://easyrpg.org/downloads/player/%{version}/%{name}-%{version}.tar.xz

Patch0:         %{name}-%{version}-fmt-string_view-api.patch

BuildRequires:  gcc-c++
BuildRequires:  libtool
BuildRequires:  pkgconfig
BuildRequires:  pkgconfig(liblcf)
BuildRequires:  pkgconfig(sdl2)
BuildRequires:  pkgconfig(fmt)
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
BuildRequires:  pkgconfig(fluidsynth)
BuildRequires:  pkgconfig(libmpg123)
%if 0%{?suse_version} > 1500
# tumbleweed needs this
BuildRequires:  mpg123-devel
%endif
BuildRequires:  libpng16-compat-devel

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
%patch0 -p1
%ifarch ppc64le
# disable powerpc intrinsics in c++ mode
sed -i -e '/^AX_CXX_COMPILE_STDCXX/ s/noext/ext/' configure.ac
autoreconf -fi
%endif

%build
%configure --enable-fmmidi --disable-maintainer-mode
make %{?_smp_mflags}

%install
%make_install

%files
%doc COPYING README.md docs/AUTHORS.md
%{_bindir}/*
%{_mandir}/man6/*
%{_datadir}/applications/%{name}.desktop
%{_datadir}/bash-completion/completions/*
%{_datadir}/icons/hicolor
%{_datadir}/metainfo/%{name}.metainfo.xml
%{_datadir}/pixmaps/%{name}.png

%changelog
* Tue Feb 13 2024 carstene1ns <dev@ f4ke .de> - 0.8-5
- Add fmt patch

* Sun Dec 03 2023 carstene1ns <dev@ f4ke .de> - 0.8-4
- OBS rebuild

* Tue May 30 2023 Ghabry <gabriel@ mastergk .de> - 0.8-3
- Upstream Update

* Tue Jun 14 2022 carstene1ns <dev@ f4ke .de> - 0.7.0-3
- OBS rebuild
- Remove fedora support, leave only modern openSUSE

* Sun Mar 13 2022 carstene1ns <dev@ f4ke .de> - 0.7.0-2
- OBS rebuild

* Sun Oct 31 2021 carstene1ns <dev@ f4ke .de> - 0.7.0-1
- Upstream update
- New dependencies

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
