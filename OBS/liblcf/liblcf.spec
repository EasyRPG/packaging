
Name:           liblcf
Version:        0.8.1
Release:        1%{?dist}
Summary:        RPG Maker 2000/2003 and EasyRPG game data library

Group:          System/Libraries
License:        MIT
URL:            https://easyrpg.org
Source0:        https://easyrpg.org/downloads/player/%{version}/%{name}-%{version}.tar.xz

# Requires:       libicu
# Requires:       libexpat1
# Requires:       libinih

BuildRequires:  cmake
BuildRequires:  ninja
BuildRequires:  c++_compiler
BuildRequires:  pkgconfig
BuildRequires:  pkgconfig(icu-i18n)
BuildRequires:  pkgconfig(expat)
BuildRequires:  pkgconfig(inih)
BuildRequires:  doxygen

%description
liblcf is a library to handle RPG Maker 2000/2003 and EasyRPG game data.
It can read and write LCF and XML files.

%package -n liblcf0
Summary:        RPG Maker 2000/2003 and EasyRPG game data library
Group:          System/Libraries

%description -n liblcf0
liblcf is a library to handle RPG Maker 2000/2003 and EasyRPG game data.
It can read and write LCF and XML files.

%package -n liblcf0-devel
Summary:        RPG Maker 2000/2003 and EasyRPG game data library - development files
Group:          Development/Libraries/C and C++
Requires:       liblcf0 = %{version}

%description -n liblcf0-devel
liblcf is a library to handle RPG Maker 2000/2003 and EasyRPG game data.
It can read and write LCF and XML files.

%package -n liblcf0-tools
Summary:        RPG Maker 2000/2003 and EasyRPG game data library - tools
Group:          Games and Entertainment
Requires:       liblcf0 = %{version}

%description -n liblcf0-tools
Tools to handle RPG Maker 2000/2003 and EasyRPG game data.
They can read and write LCF and XML files.

%prep
%setup -q

%build
%define __builder ninja
%cmake -DLIBLCF_UPDATE_MIMEDB=OFF
%cmake_build

%install
%cmake_install

%check
ninja -v %{?_smp_mflags} check -C %__builddir

%post -n liblcf0 -p /sbin/ldconfig

%postun -n liblcf0 -p /sbin/ldconfig

%files -n liblcf0
%doc COPYING README.md AUTHORS.md
%{_libdir}/liblcf.so.*
%{_datadir}/mime/packages/liblcf.xml

%files -n liblcf0-devel
%{_includedir}/lcf
%{_libdir}/liblcf.so
%{_libdir}/pkgconfig/liblcf.pc
%{_libdir}/cmake

%files -n liblcf0-tools
%{_bindir}/lcf2xml
%{_bindir}/lcfstrings

%changelog
* Tue Apr 08 2025 carstene1ns <dev@ f4ke .de> - 0.8.1-1
- Upstream Update

* Sun Dec 03 2023 carstene1ns <dev@ f4ke .de> - 0.8-2
- OBS rebuild
- Switch to CMake/Ninja

* Tue May 30 2023 Ghabry <gabriel@ mastergk .de> - 0.8-1
- Upstream Update

* Tue Jun 14 2022 carstene1ns <dev@ f4ke .de> - 0.7.0-3
- OBS rebuild

* Sun Mar 13 2022 carstene1ns <dev@ f4ke .de> - 0.7.0-2
- OBS rebuild

* Sun Oct 31 2021 carstene1ns <dev@ f4ke .de> - 0.7.0-1
- Upstream Update

* Mon Apr 27 2020 carstene1ns <dev@ f4ke .de> - 0.6.2-1
- Upstream Update

* Thu Aug 29 2019 carstene1ns <dev@ f4ke .de> - 0.6.1-1
- Upstream Update

* Sun Mar 03 2019 carstene1ns <dev@ f4ke .de> - 0.6.0-1
- Upstream Update

* Sat Oct 27 2018 carstene1ns <dev@ f4ke .de> - 0.5.4-1
- Upstream Update

* Sun Oct 22 2017 carstene1ns <dev@ f4ke .de> - 0.5.3-1
- Upstream Update

* Wed Jun 28 2017 carstene1ns <dev@ f4ke .de> - 0.5.2-1
- Upstream Update

* Sun Apr 16 2017 carstene1ns <dev@ f4ke .de> - 0.5.1-1
- Upstream Update

* Fri Sep 23 2016 carstene1ns <dev@ f4ke .de> - 0.5.0-1
- Upstream Update

* Sat Mar 19 2016 carstene1ns <dev@ f4ke .de> - 0.4.1-1
- Upstream Update

* Mon Jan 4 2016 carstene1ns <dev@ f4ke .de> - 0.4.0-1
- Initital package
