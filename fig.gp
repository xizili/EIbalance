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


# ---- psd of dynamics of 3 neurons: no oscillations ----

load 'rdylbu.pal'
set cbrange [1:3]
unset title

set lmargin at screen 0.3
set rmargin at screen 0.33

set border 3
set offsets graph 0, 0, 0, 0
set logscale
unset ylabel
set xrange [0.3:100]
set autoscale y 
set xtics 0.1, 10, 1000
set mxtics 10
unset ytics
set format x ""
unset xlabel
unset ylabel
set tmargin at screen 0.73
set bmargin at screen 0.71
plot dir."/ActivityMatrix_psd.txt" u 1:4 w l lw 2 lc 8, \
  '' u 1:21 w l lc 8 lw 2, \
  '' u 1:31 w l lc 8 lw 2, \


# ---- psd of contributions of eigenvectors: clear oscillations ----

set tmargin at screen 0.705
set bmargin at screen 0.685
unset ylabel

load 'bupu.pal'
unset log cb
set cbrange [-20:120]
unset colorbox
set ylabel '\shortstack[c]{power spectral\\density}' offset -1.5,0
plot for [i=1:120:4] dir."/ActivityContributionMatrix_psd.txt" u 1:120-i-1 w l lw 2 lc palette cb i
unset ylabel

# ---- psd of learned projections ----

set tmargin at screen 0.68
set bmargin at screen 0.66
unset ylabel
set xlabel "frequency [Hz]" offset 0,0
set format x "$10^{%L}$"
set cbrange [-5:30]
plot for [i=1:30] dir.'/learned_projections/sorted_proj_c'.(i-1).'_psd' u 1:2 w l lw 2 lc palette cb i
 

unset multiplot
unset output

# pdflatex on the other .tex file which will include the .tex 
# generated by gnuplot running on this script
system("pdflatex _tmp.tex")
system(sprintf("pdflatex %s",texfile))
system(sprintf("pdfcrop %s %s",pdffile,pdffile))
system("rm -f ./_tmp*")
system("rm -f ./*.aux ./*.log")




