
set term cairolatex pdf standalone size 100cm, 100cm dl 0.5 \
  header '\usepackage[scaled=1]{helvet}\
          \usepackage{sfmath}\
          \renewcommand{\familydefault}{\sfdefault}'
          # xcolor

texfile = system(sprintf("echo %s | sed 's/\\.gp/\\.tex/'", ARG0))
pdffile = system(sprintf("echo %s | sed 's/\\.gp/\\.pdf/'", ARG0))

set output '_tmp.tex'
set multiplot


# dir = ARG1 #  "/Users/xizi/Dropbox/work/wGuillaume/cosyne2018/data_for_figure"
# dir2 = ARG2 #  "/Users/xizi/Dropbox/work/wGuillaume/cosyne2018/arm_model_data"
dir = "/Users/xizi/Dropbox/work/wGuillaume/cosyne2018/data_for_figure"
dir2 = "/Users/xizi/Dropbox/work/wGuillaume/cosyne2018/arm_model_data"



# ---- psd of dynamics of 3 neurons: no oscillations ----


load 'rdylbu.pal'
set cbrange [1:3]

set lmargin at screen 0.3
set rmargin at screen 0.33
nn = 3
gap=0.002
tm=0.8
bm=0.71
w=(tm-bm-(nn-1)*gap)/nn

i=0
set tmargin at screen bm+i*gap+i*w+w
set bmargin at screen bm+i*gap+i*w

set border 3
set logscale

set xlabel "frequency [Hz]" offset 0,0
set ylabel "power [dB]" offset 0,0

set xrange [0.1:1000]
set yrange [1e-10:1]

set xtics (0.1,1,10,100, 1000) 
set format x "$10^{%L}$"
set ytics offset 0,0
set ytics (1e-10,"" 1e-8, "" 1e-6, "" 1e-4, "" 1e-2, 1) 
set format y "$10^{%L}$"

n=3
plot dir."/ActivityMatrix_psd.txt" u 1:n+1 w l lw 2 lc palette cb i+1


i=1
set tmargin at screen bm+i*gap+i*w+w
set bmargin at screen bm+i*gap+i*w
n=20
replot

i=2
set tmargin at screen bm+i*gap+i*w+w
set bmargin at screen bm+i*gap+i*w
n=40
replot





# ---- psd of contributions of eigenvectors: clear oscillations ----

set lmargin at screen 0.34
set rmargin at screen 0.37

nn = 3
gap=0.002
tm=0.8
bm=0.71
w=(tm-bm-(nn-1)*gap)/nn

i=0
set tmargin at screen bm+i*gap+i*w+w
set bmargin at screen bm+i*gap+i*w

set border 3
set logscale

set xlabel "frequency [Hz]" offset 0,0
set ylabel "power [dB]" offset 0,0

set xrange [0.1:1000]
set yrange [1e-10:1]

set xtics (0.1,1,10,100, 1000) 
set format x "$10^{%L}$"
set ytics offset 0,0
set ytics (1e-10,"" 1e-8, "" 1e-6, "" 1e-4, "" 1e-2, 1) 
set format y "$10^{%L}$"

n=3
plot dir."/ActivityContributionMatrix_psd.txt" u 1:n w l lw 2 lc palette cb i+1


i=1
set tmargin at screen bm+i*gap+i*w+w
set bmargin at screen bm+i*gap+i*w
n=20
replot

i=2
set tmargin at screen bm+i*gap+i*w+w
set bmargin at screen bm+i*gap+i*w
n=40
replot




# ---- psd of projections onto extracted orthogonal basis: some oscillations ----


set lmargin at screen 0.38
set rmargin at screen 0.41

nn = 3
gap=0.002
tm=0.8
bm=0.71
w=(tm-bm-(nn-1)*gap)/nn

i=0
set tmargin at screen bm+i*gap+i*w+w
set bmargin at screen bm+i*gap+i*w

set border 3
set logscale

set xlabel "frequency [Hz]" offset 0,0
set ylabel "power [dB]" offset 0,0

set xrange [0.1:1000]
set yrange [1e-10:1]

set xtics (0.1,1,10,100, 1000) 
set format x "$10^{%L}$"
set ytics offset 0,0
set ytics (1e-10,"" 1e-8, "" 1e-6, "" 1e-4, "" 1e-2, 1) 
set format y "$10^{%L}$"

n=3
plot dir."/ActivityContributionMatrix_psd.txt" u 1:n w l lw 2 lc palette cb i+1


i=1
set tmargin at screen bm+i*gap+i*w+w
set bmargin at screen bm+i*gap+i*w
n=20
replot

i=2
set tmargin at screen bm+i*gap+i*w+w
set bmargin at screen bm+i*gap+i*w
n=40
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