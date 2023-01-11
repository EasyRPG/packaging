#!/bin/bash

cat <<'EOD' | neato -Tsvg | convert svg:- -resize 80% distributions.png
graph distributions {
	# neato
	layout="neato";
	overlap=false;
	splines=true;

	node[width=.3, height=.3];

	# archs

	node[color=black, shape=oval];
	x86_64;
	i586;
	armv7l;
	aarch64;

	# distris

	node[shape=rectangle];

	node[color=red];
	Debian;
	d10 [label="10"];
	d11 [label="11"];
	dt  [label="testing"];
	du  [label="unstable"];

	node[color="#B3446C"];
	Raspbian;
	r10 [label="10"];
	r11 [label="11"];

	node[color=green];
	openSUSE;
	s153 [label="Leap 15.3"];
	s154 [label="Leap 15.4"];
	st   [label="Tumbleweed"];

	node[color=orange];
	xUbuntu;
	u1804 [label="18.04"];
	u2004 [label="20.04"];
	u2110 [label="21.10"];
	u2204 [label="22.04"];

	node[color=blue];
	Arch;

	# connect!
	edge[color=blue];
	Arch -- x86_64

	edge[color=red];
	d10 -- { x86_64 i586 aarch64 };
	d11 -- { x86_64 i586 };
	dt -- x86_64;
	du -- x86_64;

	edge[color="#B3446C"];
	r10 -- armv7l;
	r11 -- armv7l;

	edge[color=green];
	s153 -- x86_64;
	s154 -- x86_64;
	st -- { x86_64 i586 };

	edge[color=orange];
	u1804 -- x86_64;
	u2004 -- x86_64;
	u2110 -- x86_64;
	u2204 -- x86_64;

	# order!

	edge [style=dotted, color=gray];
	Debian -- {d10 d11 dt du}
	Raspbian -- {r10 r11}
	openSUSE -- {s153 s154 st}
	xUbuntu -- {u1804 u2004 u2110 u2204}
}
EOD
