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

 dir = ARG1 #  "/Users/xizi/Dropbox/work/wGuillaume/cosyne2018/data_for_figure"
 dir2 = ARG2 #  "/Users/xizi/Dropbox/work/wGuillaume/cosyne2018/arm_model_data"
# dir = "/Users/xizi/Dropbox/work/wGuillaume/cosyne2018/data_for_figure"
# dir2 = "/Users/xizi/Dropbox/work/wGuillaume/cosyne2018/arm_model_data"


# ---- weight matrix and associated spectrum ----

set lmargin at screen 0.3
set rmargin at screen 0.33
set tmargin at screen 0.8
set bmargin at screen 0.77

set border 15
set palette model RGB defined (-4 '#56b4e9', 0 'white', 2 '#e51e10')
set cbrange [-4:2]
set cbtics -4,2,2 in mirror offset 1.5,0
set xrange [-0.5:199.5]
set yrange [199.5:-0.5]
unset xtics
unset ytics
set xlabel 'neuron $j$'
set ylabel 'neuron $i$'
set format cb "[r]{%g}"
set cblabel '$W_{ij}$' norotate offset 1,0

plot dir.'/w.txt' mat w image pixels


set lmargin at screen 0.356
set rmargin at screen 0.39
set border 9
set xtics -15,5,5 in nomirror
set y2tics -5,5,5 in nomirror offset 1.5,0
set arrow 1 from graph 0, graph 0.5 to graph 1, graph 0.5 nohead lc rgb 'gray' lw 3 back
set arrow 2 from first 0, graph 0 to first 0, graph 1 nohead lc rgb 'gray' lw 3 back
set format x "%g"
set format y2 "[r]{%g}"
set xlabel 'real'
set y2label 'imaginary' offset -0.5,0

set xrange [-10.5:1.5] # 12
set y2range [-6:6] # 12
plot dir.'/w_sp.txt' axes x1y2 w p pt 7 lc 8 ps 0.3
unset arrow

# ---- activity of example neurons ----

load 'rdylbu.pal'
set cbrange [1:8]

set tmargin at screen 0.758
set bmargin at screen 0.738
nn = 3
gap=0.002
lm=0.3
rm=0.39
w=(rm-lm-(nn-1)*gap)/nn

i=0
set lmargin at screen lm+i*gap+i*w
set rmargin at screen lm+i*gap+i*w+w

unset border
unset zeroaxis
unset tics
unset xlabel
unset y2label
set border 2
set ylabel 'rate [Hz]'
set offsets graph 0.1, 0, 0, 0
set ytics ('0' 0, '20' 1, '40' 2, '60' 3) in nomirror
set object 1 rectangle from first 100, graph 0 rto first 200, graph -0.03 fs solid 1.0 noborder fc rgb 'black' front noclip
set label 1 '[lb]{\scalebox{0.8}{200 ms}}' at first 100, graph 0.02
n=10
set xrange [0:600]
set yrange [0:3.5]
unset colorbox
plot for [m=1:8] dir2.'/for_xizi_cortex_trans_mvt_'.m u n w l lc palette cb m lw 3
unset border
unset ytics
unset ylabel
unset object 1
unset label 1


i=1
set lmargin at screen lm+i*gap+i*w
set rmargin at screen lm+i*gap+i*w+w
n=122
replot

i=2
set lmargin at screen lm+i*gap+i*w
set rmargin at screen lm+i*gap+i*w+w
n=3
replot




# ---- detailed balance ----

lm=0.42
rm=0.51
tm=0.83
bm=0.75
vgap=0.01
hgap=0.01
nc=3
nr=3
w=(rm-lm-(nc-1)*hgap)/nc
h=(tm-bm-(nr-1)*vgap)/nr
psbig=0.8
pssmall=0.4

set xrange [-45:180]
set autoscale y
set xtics -90, 90, 180 out nomirror
set mxtics 2
set format x ""
set offsets graph 0.1, graph 0, graph 0, graph 0.2  

do for [c=0:2] {

if (c==0) { n=2 }
if (c==1) { n=38 }
if (c==2) { n=125 }

if (c==0) { border_c = 0 } else { border_c = 0 }

set lmargin at screen lm+c*(w+hgap)
set rmargin at screen lm+c*(w+hgap)+w

time=1
r=0
set tmargin at screen tm-r*(h+vgap)
set bmargin at screen tm-r*(h+vgap)-h
set border 1+border_c
set title 'neuron '.n
plot dir.'/Arm_EI_'.time.'.txt' u 1:n+1 w lp pt 7 lc 7 ps psbig lw 3, \
     '' u 1:n+1 w p pt 7 lc rgb 'white' ps pssmall, \
     '' u 1:(+column(200+n+1)) w lp pt 7 lc 3 ps 1 lw 3, \
     '' u 1:(+column(200+n+1)) w p pt 7 lc rgb 'white' ps pssmall
unset title

time=200
r=1
set tmargin at screen tm-r*(h+vgap)
set bmargin at screen tm-r*(h+vgap)-h
replot

time=400
r=2
if (c==0) { set format x "%g"; set xlabel 'reach angle (deg)' offset 1,0 }
set tmargin at screen tm-r*(h+vgap)
set bmargin at screen tm-r*(h+vgap)-h
replot
set format x ""
unset xlabel
 
}

# histograms of E/I balance

set lmargin at screen 0.52
set rmargin at screen 0.54
set xrange [-1.15:1.15]
set xtics -1,1,1 out nomirror
set mxtics 2
set format x ""
set border 1
set boxwidth 0.2
binwidth=0.2
bin(val)=binwidth*floor(val/binwidth)
set offsets 0, 0, graph 0.5, 0

r=0
set title '$t=1$ ms' offset 0, -2.5
set tmargin at screen tm-r*(h+vgap)
set bmargin at screen tm-r*(h+vgap)-h
time = 1
plot dir.'/EI_cor_'.time u (bin($1)):(1.0) smooth frequency w boxes lc rgb 'black' fs solid 0.2

r=1
set title '$t=200$ ms' offset 0, -2.5
set tmargin at screen tm-r*(h+vgap)
set bmargin at screen tm-r*(h+vgap)-h
time = 200
replot
 
r=2
set title '$t=400$ ms' offset 0, -2.5
set tmargin at screen tm-r*(h+vgap)
set bmargin at screen tm-r*(h+vgap)-h
set format x "%g"
set xlabel 'E/I cor.'
time = 400
replot



unset multiplot
unset output

# pdflatex on the other .tex file which will include the .tex 
# generated by gnuplot running on this script
system("pdflatex _tmp.tex")
system(sprintf("pdflatex %s",texfile))
system(sprintf("pdfcrop %s %s",pdffile,pdffile))
system("rm -f ./_tmp*")
system("rm -f ./*.aux ./*.log")























# 
#set cbtics (0, "$\\frac{\\pi}{4}$" 0.7854, "$\\frac{\\pi}{2}$" 1.5708)




#set xlabel "eigenplanes" font "Helvetica,20"  
#set ylabel "eigenplanes" font "Helvetica,20" offset +2,0
#
#set xrange [1:103]
#set yrange [103:1]
#
#set tics in
#set xtics (1,103) nomirror
#set format x "%g"
#set ytics (1,103) nomirror
#set format y "%g"
#
#plot dir."/w.txt" mat w image
#
#
#
#
##plot (2,1) -right  matrix W SPA
#
#set lmargin at screen 0.34
#set rmargin at screen 0.42
#set tmargin at screen 0.88
#set bmargin at screen 0.55
#
#set xzeroaxis 
#set arrow from 1, graph 0 to 1, graph 1 nohead lc rgb "red" dt 2
#
#unset label
#set xlabel "real part" font "Helvetica,20"
#set ylabel "imag. part " font "Helvetica,20" offset +1,0
#
#set xrange [-25:2]
#set yrange [-15:15]
#
#set xtics (-20,"" -10,0,"" 10) nomirror
#set xtics font "Times-Roman, 20" offset 0,-0.3
#set ytics (-15,0,15) nomirror 
#set ytics in
#
#
#plot dir."/Connty_W.txt" w p pt 7 ps 0.3 lc rgb 'black',\
#     dir."/Connty_W_select.txt" u 1:2 w p pt 7 ps 0.5 lc rgb '#dark-violet',\
#     "" u 1:3 w p pt 7 ps 0.3 lc rgb "#009e73",\
#     "" u 1:4 w p pt 7 ps 0.3 lc rgb "#56b4e9",\
#     "" u 1:5 w p pt 7 ps 0.3 lc rgb "#e69f00",\
#     "" u 1:6 w p pt 7 ps 0.3 lc rgb "#f0e442"
#
#
##plot (3,1) neural response
#
#set lmargin at screen 0.05
#set rmargin at screen 0.26
#set tmargin at screen 0.88
#set bmargin at screen 0.55
#
#set border 3
#
#set xlabel "time(s)"
#set ylabel "potentials" offset -1,0
#
#set xrange [0:1]
#set yrange [-10:20]
#
#set xtics (0,0.2,0.4,0.6,0.8) nomirror
#set ytics (-10,0,10,20) nomirror
#
#unset key
#
## load dir2."/set3.pal"
## set cbrange [2:6] 
## plot for [i=2:6] dir."/ActivityMatrix.txt" u 1:i w l lw 2 lc palette cb i 
#plot  dir."/ActivityMatrix_select.txt" u 1:2 w l lw 2 lc rgb "#8dd3c7" ,\
#     "" u 1:3 w l lw 2 lc rgb "#ffffb3" ,\
#     "" u 1:4 w l lw 2 lc rgb "#bebada" ,\
#     "" u 1:5 w l lw 2 lc rgb "#fb8072" ,\
#     "" u 1:6 w l lw 2 lc rgb "#80b1d3" 
#
#
##load "rdbu.pal"
##set cbrange [2:6]
##plot for [c=2:6] dir."/ActivityProjection_psd.txt" u 1:c w l lw 2 lc palette cb c
#
#
#
#
## plot (1:3, 2:4) EI balance
#
##plot C(1,1) - c
#
#set tmargin at screen 0.86
#set bmargin at screen 0.66
#set lmargin at screen 0.63
#set rmargin at screen 0.70
#
#unset logscale
#unset xlabel
#unset key
#
#set border 2
#unset xlabel
#set xrange [-41:221]
#set yrange [0:1]
#
#unset xtics
#set ytics (0, "" 0.5,1.0) nomirror
#set ylabel "At 2ms" font "Helvetica,20" offset -1,0
#
#unset key
#set title "neuron 1" offset 0,+1
#
#plot dir."/Arm_detailedbalance_2.txt" u 1:2 w lp ls 1,\
#     "" u 1:6 w lp ls 2
#
#
##plot C(1,2) - c
#set lmargin at screen 0.72
#set rmargin at screen 0.79
#unset border 
#unset label
#unset ylabel
#unset ytics
##set ytics ("" 0, "" 0.5,"" 1.0) nomirror
#set title "neuron 2"
#plot dir."/Arm_detailedbalance_2.txt" u 1:3 w lp ls 1,\
#     "" u 1:7 w lp ls 2
#
#
##plot C(1,3) - c
#set lmargin at screen 0.81
#set rmargin at screen 0.88
#set title "neuron 3"
#plot dir."/Arm_detailedbalance_2.txt" u 1:4 w lp ls 1,\
#     "" u 1:8 w lp ls 2
#
#
#
#
#
##plot C(2,1) - c
#set tmargin at screen 0.6
#set bmargin at screen 0.4
#set lmargin at screen 0.63
#set rmargin at screen 0.70
#
#set border 2
#set ylabel "At 50ms" font "Helvetica,20" 
#set ytics (0, "" 0.5,1.0) nomirror
#unset title
#plot dir."/Arm_detailedbalance_50.txt" u 1:2 w lp ls 1,\
#     "" u 1:6 w lp ls 2
#
#
##plot C(2,2) - c
#set lmargin at screen 0.72
#set rmargin at screen 0.79
#unset border 
#unset ylabel
#unset ytics
##set ytics ("" 0, "" 0.5,"" 1.0) nomirror
#plot dir."/Arm_detailedbalance_50.txt" u 1:3 w lp ls 1,\
#     "" u 1:7 w lp ls 2
#
##plot C(2,3) - c
#set lmargin at screen 0.81
#set rmargin at screen 0.88
#plot dir."/Arm_detailedbalance_50.txt" u 1:4 w lp ls 1,\
#     "" u 1:8 w lp ls 2
#
#
#
#
#
##plot C(3,1) - c
#set tmargin at screen 0.34
#set bmargin at screen 0.14
#set lmargin at screen 0.63
#set rmargin at screen 0.70
#set border 3
#set ylabel "At 200ms" font "Helvetica,20" 
#set ytics (0, "" 0.5,1.0) nomirror
#set xlabel "arm angles" font "Helvetica,20" offset 0,-1
#set xtics ("1" -36,"2" 0,"3" 36,"4" 72,"5" 108,"6" 144,"7" 180,"8" 216) nomirror
#set xtics font "Times-Roman, 5"
#unset title
#plot dir."/Arm_detailedbalance_200.txt" u 1:2 w lp ls 1,\
#     "" u 1:6 w lp ls 2
#
##plot C(3,2) - c
#set lmargin at screen 0.72
#set rmargin at screen 0.79
#set border 1
#unset xlabel
#unset ylabel
#set xtics ("" -36,"" 0,"" 36,"" 72,"" 108,"" 144,"" 180,"" 216) nomirror
#unset ytics #set ytics ("" 0, "" 0.5,"" 1.0) nomirror
#plot dir."/Arm_detailedbalance_200.txt" u 1:3 w lp ls 1,\
#     "" u 1:7 w lp ls 2
#
##plot C(3,3) - c
#set lmargin at screen 0.81
#set rmargin at screen 0.88
#plot dir."/Arm_detailedbalance_200.txt" u 1:4 w lp ls 1,\
#     "" u 1:8 w lp ls 2
#
#
#
#
#
#



  
