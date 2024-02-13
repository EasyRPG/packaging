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
	d12 [label="12"];
	dt  [label="testing"];
	du  [label="unstable"];

	node[color="#B3446C"];
	Raspbian;
	r10 [label="10"];
	r11 [label="11"];
	r12 [label="12"];

	node[color=green];
	openSUSE;
	s154 [label="Leap 15.4"];
	s155 [label="Leap 15.5"];
	s156 [label="Leap 15.6"];
	st   [label="Tumbleweed"];

	node[color=orange];
	xUbuntu;
	u2004 [label="20.04"];
	u2204 [label="22.04"];
	u2304 [label="23.04"];
	u2310 [label="23.10"];

	node[color=blue];
	Arch;

	# connect!
	edge[color=blue];
	Arch -- x86_64

	edge[color=red];
	d10 -- { x86_64 i586 aarch64 };
	d11 -- { x86_64 i586 };
	d12 -- { x86_64 i586 };
	dt -- x86_64;
	du -- x86_64;

	edge[color="#B3446C"];
	r10 -- armv7l;
	r11 -- armv7l;
	r12 -- armv7l;

	edge[color=green];
	s154 -- x86_64;
	s155 -- x86_64;
	s156 -- x86_64;
	st -- { x86_64 i586 };

	edge[color=orange];
	u2004 -- x86_64;
	u2204 -- x86_64;
	u2304 -- x86_64;
	u2310 -- x86_64;

	# order!

	edge [style=dotted, color=gray];
	Debian -- {d10 d11 d12 dt du}
	Raspbian -- {r10 r11 r12}
	openSUSE -- {s154 s155 s156 st}
	xUbuntu -- {u2004 u2204 u2304 u2310}
}
EOD
