set title "Monitor"
set xlabel 'Step'
set ylabel 'Pressure Gradient'
# set yrange [0:7000]
plot "<cat log.pimpleFoam | grep 'pressure gradient =' | cut -d' ' -f11" title 'pppx'  with lines
# pause 10
# reread