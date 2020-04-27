
Name:           liblcf
Version:        0.6.2
Release:        1%{?dist}
Summary:        RPG Maker 2000/2003 and EasyRPG game data library

Group:          System/Libraries
License:        MIT
URL:            https://easyrpg.org
Source0:        https://easyrpg.org/downloads/player/%{version}/%{name}-%{version}.tar.xz

# Requires:       libicu
# Requires:       libexpat1

%if 0%{?suse_version}
BuildRequires:  c++_compiler
%else
BuildRequires:  gcc-c++
%endif
BuildRequires:  libtool
BuildRequires:  pkgconfig
BuildRequires:  pkgconfig(icu-i18n)
BuildRequires:  pkgconfig(expat)
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

%prep
%setup -q

%build
#Tumbleweed hack
%if 0%{?suse_version} > 1500
export CXXFLAGS="%{build_cxxflags} -ffat-lto-objects"
%endif
%configure --disable-update-mimedb
make %{?_smp_mflags}

%check
make check

%install
%make_install
rm %{buildroot}%{_libdir}/liblcf.la

%post -n liblcf0 -p /sbin/ldconfig

%postun -n liblcf0 -p /sbin/ldconfig

%files -n liblcf0
%if 0%{?suse_version}
%doc COPYING
%else
%license COPYING
%endif
%doc README.md AUTHORS.md
%{_libdir}/liblcf.so.*
%{_datadir}/mime/packages/liblcf.xml

%files -n liblcf0-devel
%{_includedir}/liblcf
%{_libdir}/liblcf.a
%{_libdir}/liblcf.so
%{_libdir}/pkgconfig/liblcf.pc
%if 0%{?suse_version}
%{_libdir}/cmake
%else
%{_libdir}/cmake/liblcf
%endif

%changelog
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
