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
	ppc64le;

	# distris

	node[shape=rectangle];

	node[color=red];
	Debian;
	d11 [label="11"];
	d12 [label="12"];
	dt  [label="testing"];
	du  [label="unstable"];

	node[color="#B3446C"];
	Raspbian;
	r11 [label="11"];
	r12 [label="12"];

	node[color=green];
	openSUSE;
	s156 [label="Leap 15.6"];
	s160 [label="Leap 16.0"];
	sfa  [label="Factory ARM"]
	sfp  [label="Factory PowerPC"]
	sl   [label="Slowroll"];
	st   [label="Tumbleweed"];

	node[color=orange];
	xUbuntu;
	u2204 [label="22.04"];
	u2404 [label="24.04"];
	u2410 [label="24.10"];
	u2504 [label="25.04"];

	node[color=blue];
	Arch;

	# connect!
	edge[color=blue];
	Arch -- x86_64

	edge[color=red];
	d11 -- { x86_64 i586 };
	d12 -- { x86_64 i586 };
	dt -- x86_64;
	du -- x86_64;

	edge[color="#B3446C"];
	r11 -- armv7l;
	r12 -- armv7l;

	edge[color=green];
	s156 -- x86_64;
	s160 -- x86_64;
	sfa -- aarch64;
	sfp -- ppc64le;
	sl -- { x86_64 i586 };
	st -- { x86_64 i586 };

	edge[color=orange];
	u2204 -- x86_64;
	u2404 -- x86_64;
	u2410 -- x86_64;
	u2504 -- x86_64;

	# order!

	edge [style=dotted, color=gray];
	Debian -- {d11 d12 dt du}
	Raspbian -- {r11 r12}
	openSUSE -- {s156 s160 sfa sfp sl st}
	xUbuntu -- {u2204 u2404 u2410 u2504}
}
EOD
