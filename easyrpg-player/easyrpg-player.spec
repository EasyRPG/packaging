
Name:           easyrpg-player
Version:        0.4.0
Release:        1%{?dist}
Summary:        Game interpreter to play RPG Maker 2000, 2003 and EasyRPG games

Group:          Games
License:        GPLv3
URL:            https://easy-rpg.org
Source0:        https://easy-rpg.org/downloads/player/%{name}-%{version}.tar.gz

# Requires:       liblcf
# Requires:       libSDL2-2_0-0
# Requires:       libSDL2_mixer-2_0-0
# Requires:       libpixman-1-0
# Requires:       libfreetype6

%if 0%{?suse_version}
BuildRequires:  c++_compiler
%else
BuildRequires:  gcc-c++
%endif
BuildRequires:  libtool
BuildRequires:  pkgconfig
BuildRequires:  pkgconfig(liblcf)
BuildRequires:  boost-devel
BuildRequires:  pkgconfig(sdl2)
BuildRequires:  pkgconfig(SDL2_mixer)
BuildRequires:  pkgconfig(pixman-1)
BuildRequires:  pkgconfig(freetype2)
%if 0%{?suse_version}
BuildRequires:  libpng16-devel
BuildRequires:  libpng16-compat-devel
%else
BuildRequires:  pkgconfig(libpng16)
%endif
BuildRequires:  doxygen

%description
EasyRPG Player is a program that allows to play games created with
RPG Maker 2000 and 2003. It aims to be a free (as in freedom)
cross-platform RPG Maker 2000/2003 interpreter. The main goal is
to play all games created with them as the original game interpreter
(RPG_RT) does. 

%prep
%setup -q

%build
%configure
make %{?_smp_mflags}

%install
%make_install

%files
%if 0%{?suse_version}
%doc COPYING
%else
%license COPYING
%endif
%doc README AUTHORS
%{_bindir}/*
%{_mandir}/man6/*

%changelog
