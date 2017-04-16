
Name:           easyrpg-player
Version:        0.5.1
Release:        1%{?dist}
Summary:        Game interpreter to play RPG Maker 2000, 2003 and EasyRPG games

Group:          Games
License:        GPL-3.0
URL:            https://easyrpg.org
Source0:        https://easyrpg.org/downloads/player/%{name}-%{version}.tar.gz
Patch0:         guard-sdl-mousewheel.patch

# seems to be done automatically
#Requires:       liblcf
#Requires:       libSDL2-2_0-0
#Requires:       libSDL2_mixer-2_0-0
#Requires:       libpixman-1-0
#Requires:       libfreetype6
#Requires:       libpng16

%if 0%{?suse_version}
BuildRequires:  c++_compiler
%else
BuildRequires:  gcc-c++
%endif
BuildRequires:  libtool
BuildRequires:  pkgconfig
BuildRequires:  pkgconfig(liblcf)
BuildRequires:  pkgconfig(sdl2)
BuildRequires:  pkgconfig(SDL2_mixer)
BuildRequires:  pkgconfig(pixman-1)
BuildRequires:  pkgconfig(freetype2)
BuildRequires:  pkgconfig(ogg)
BuildRequires:  pkgconfig(vorbis)
BuildRequires:  pkgconfig(speexdsp)
BuildRequires:  pkgconfig(sndfile)
BuildRequires:  pkgconfig(libxmp)
BuildRequires:  pkgconfig(bash-completion)
# mpg123 still not available?
#BuildRequires:  pkgconfig(libmpg123)
%if 0%{?suse_version}
BuildRequires:  libpng16-devel
BuildRequires:  libpng16-compat-devel
%else
BuildRequires:  pkgconfig(libpng16)
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
%patch0

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
