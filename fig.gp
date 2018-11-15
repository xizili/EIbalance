

set term cairolatex pdf standalone size 100cm, 100cm dl 0.5 \
  header '\usepackage[scaled=1]{helvet}\
          \usepackage{sfmath}\
          \renewcommand{\familydefault}{\sfdefault}'
          # xcolor

texfile = system(sprintf("echo %s | sed 's/\\.gp/\\.tex/'", ARG0))
pdffile = system(sprintf("echo %s | sed 's/\\.gp/\\.pdf/'", ARG0))

set output '_tmp.tex'
set multiplot


set style line 1 lt 1 lw 2 pt 5 ps 0.5 lc rgb "#e51e10"
set style line 2 lt 1 lw 2 pt 9 ps 0.8 lc rgb "#56b4e9"


dir = "/Users/xizi/Desktop/cosyne"
dir2 = "/Users/xizi/utils/gnuplot-palettes"

set label "a" at screen 0.02,0.94 font "Symbol,40" tc rgb 'black' 
set label "b" at screen 0.30,0.94 font "Symbol,40" tc rgb 'black' 
set label "c" at screen 0.60,0.94 font "Symbol,40" tc rgb 'black' 


#plot (1,1) 

#plot (2,1) -left  matrix W

set lmargin at screen 0.47
set rmargin at screen 0.55
set tmargin at screen 0.88
set bmargin at screen 0.55

unset border 
unset xzeroaxis 
unset arrow

set palette model RGB defined (0 'white', 1.5708 'orange')
set cbrange [0:1.5708]
set cbtics (0, "$\\frac{\\pi}{4}$" 0.7854, "$\\frac{\\pi}{2}$" 1.5708)

set xlabel "eigenplanes" font "Helvetica,20"  
set ylabel "eigenplanes" font "Helvetica,20" offset +2,0

set xrange [1:103]
set yrange [103:1]

set tics in
set xtics (1,103) nomirror
set format x "%g"
set ytics (1,103) nomirror
set format y "%g"

plot dir."/AngleMap.txt" mat w image




#plot (2,1) -right  matrix W SPA

set lmargin at screen 0.34
set rmargin at screen 0.42
set tmargin at screen 0.88
set bmargin at screen 0.55

set xzeroaxis 
set arrow from 1, graph 0 to 1, graph 1 nohead lc rgb "red" dt 2

unset label
set xlabel "real part" font "Helvetica,20"
set ylabel "imag. part " font "Helvetica,20" offset +1,0

set xrange [-25:2]
set yrange [-15:15]

set xtics (-20,"" -10,0,"" 10) nomirror
set xtics font "Times-Roman, 20" offset 0,-0.3
set ytics (-15,0,15) nomirror 
set ytics in


plot dir."/Connty_W.txt" w p pt 7 ps 0.3 lc rgb 'black',\
     dir."/Connty_W_select.txt" u 1:2 w p pt 7 ps 0.5 lc rgb '#dark-violet',\
     "" u 1:3 w p pt 7 ps 0.3 lc rgb "#009e73",\
     "" u 1:4 w p pt 7 ps 0.3 lc rgb "#56b4e9",\
     "" u 1:5 w p pt 7 ps 0.3 lc rgb "#e69f00",\
     "" u 1:6 w p pt 7 ps 0.3 lc rgb "#f0e442"


#plot (3,1) neural response

set lmargin at screen 0.05
set rmargin at screen 0.26
set tmargin at screen 0.88
set bmargin at screen 0.55

set border 3

set xlabel "time(s)"
set ylabel "potentials" offset -1,0

set xrange [0:1]
set yrange [-10:20]

set xtics (0,0.2,0.4,0.6,0.8) nomirror
set ytics (-10,0,10,20) nomirror

unset key

# load dir2."/set3.pal"
# set cbrange [2:6] 
# plot for [i=2:6] dir."/ActivityMatrix.txt" u 1:i w l lw 2 lc palette cb i 
plot  dir."/ActivityMatrix_select.txt" u 1:2 w l lw 2 lc rgb "#8dd3c7" ,\
     "" u 1:3 w l lw 2 lc rgb "#ffffb3" ,\
     "" u 1:4 w l lw 2 lc rgb "#bebada" ,\
     "" u 1:5 w l lw 2 lc rgb "#fb8072" ,\
     "" u 1:6 w l lw 2 lc rgb "#80b1d3" 


#load "rdbu.pal"
#set cbrange [2:6]
#plot for [c=2:6] dir."/ActivityProjection_psd.txt" u 1:c w l lw 2 lc palette cb c




# plot (1:3, 2:4) EI balance

#plot C(1,1) - c

set tmargin at screen 0.86
set bmargin at screen 0.66
set lmargin at screen 0.63
set rmargin at screen 0.70

unset logscale
unset xlabel
unset key

set border 2
unset xlabel
set xrange [-41:221]
set yrange [0:1]

unset xtics
set ytics (0, "" 0.5,1.0) nomirror
set ylabel "At 2ms" font "Helvetica,20" offset -1,0

unset key
set title "neuron 1" offset 0,+1

plot dir."/Arm_detailedbalance_2.txt" u 1:2 w lp ls 1,\
     "" u 1:6 w lp ls 2


#plot C(1,2) - c
set lmargin at screen 0.72
set rmargin at screen 0.79
unset border 
unset label
unset ylabel
unset ytics
#set ytics ("" 0, "" 0.5,"" 1.0) nomirror
set title "neuron 2"
plot dir."/Arm_detailedbalance_2.txt" u 1:3 w lp ls 1,\
     "" u 1:7 w lp ls 2


#plot C(1,3) - c
set lmargin at screen 0.81
set rmargin at screen 0.88
set title "neuron 3"
plot dir."/Arm_detailedbalance_2.txt" u 1:4 w lp ls 1,\
     "" u 1:8 w lp ls 2





#plot C(2,1) - c
set tmargin at screen 0.6
set bmargin at screen 0.4
set lmargin at screen 0.63
set rmargin at screen 0.70

set border 2
set ylabel "At 50ms" font "Helvetica,20" 
set ytics (0, "" 0.5,1.0) nomirror
unset title
plot dir."/Arm_detailedbalance_50.txt" u 1:2 w lp ls 1,\
     "" u 1:6 w lp ls 2


#plot C(2,2) - c
set lmargin at screen 0.72
set rmargin at screen 0.79
unset border 
unset ylabel
unset ytics
#set ytics ("" 0, "" 0.5,"" 1.0) nomirror
plot dir."/Arm_detailedbalance_50.txt" u 1:3 w lp ls 1,\
     "" u 1:7 w lp ls 2

#plot C(2,3) - c
set lmargin at screen 0.81
set rmargin at screen 0.88
plot dir."/Arm_detailedbalance_50.txt" u 1:4 w lp ls 1,\
     "" u 1:8 w lp ls 2





#plot C(3,1) - c
set tmargin at screen 0.34
set bmargin at screen 0.14
set lmargin at screen 0.63
set rmargin at screen 0.70
set border 3
set ylabel "At 200ms" font "Helvetica,20" 
set ytics (0, "" 0.5,1.0) nomirror
set xlabel "arm angles" font "Helvetica,20" offset 0,-1
set xtics ("1" -36,"2" 0,"3" 36,"4" 72,"5" 108,"6" 144,"7" 180,"8" 216) nomirror
set xtics font "Times-Roman, 5"
unset title
plot dir."/Arm_detailedbalance_200.txt" u 1:2 w lp ls 1,\
     "" u 1:6 w lp ls 2

#plot C(3,2) - c
set lmargin at screen 0.72
set rmargin at screen 0.79
set border 1
unset xlabel
unset ylabel
set xtics ("" -36,"" 0,"" 36,"" 72,"" 108,"" 144,"" 180,"" 216) nomirror
unset ytics #set ytics ("" 0, "" 0.5,"" 1.0) nomirror
plot dir."/Arm_detailedbalance_200.txt" u 1:3 w lp ls 1,\
     "" u 1:7 w lp ls 2

#plot C(3,3) - c
set lmargin at screen 0.81
set rmargin at screen 0.88
plot dir."/Arm_detailedbalance_200.txt" u 1:4 w lp ls 1,\
     "" u 1:8 w lp ls 2








unset multiplot
unset output

# pdflatex on the other .tex file which will include the .tex 
# generated by gnuplot running on this script
system("pdflatex _tmp.tex")
system(sprintf("pdflatex %s",texfile))
system(sprintf("pdfcrop %s %s",pdffile,pdffile))
system("rm -f ./_tmp*")
system("rm -f ./*.aux ./*.log")
  
