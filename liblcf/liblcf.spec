
Name:           liblcf
Version:        0.5.0
Release:        1%{?dist}
Summary:        RPG Maker 2000/2003 and EasyRPG game data library

Group:          System/Libraries
License:        MIT
URL:            https://easyrpg.org
Source0:        https://easyrpg.org/downloads/player/%{name}-%{version}.tar.gz

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
Group:          Development/Libraries
Requires:       liblcf0 = %{version}

%description -n liblcf0-devel
liblcf is a library to handle RPG Maker 2000/2003 and EasyRPG game data.
It can read and write LCF and XML files.

%prep
%setup -q

%build
%configure
make %{?_smp_mflags}

%check
%ifarch x86_64
make check
%endif

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
%doc README AUTHORS
%{_libdir}/liblcf.so.*

%files -n liblcf0-devel
%{_includedir}/liblcf
%{_libdir}/liblcf.a
%{_libdir}/liblcf.so
%{_libdir}/pkgconfig/liblcf.pc

%changelog
* Fri Sep 23 2016 carstene1ns <dev@ f4ke .de> - 0.5.0-1
- Upstream Update

* Sat Mar 19 2016 carstene1ns <dev@ f4ke .de> - 0.4.1-1
- Upstream Update

* Mon Jan 4 2016 carstene1ns <dev@ f4ke .de> - 0.4.0-1
- Initital package
