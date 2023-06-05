import sys

with open("headless.dat", 'r') as f:
    num_lines = 0
    sum_ns_total = 0
    sum_react = 0
    sum_vel_step = 0
    sum_dens_step = 0

    for line in f:
        line = line.split(':')[0]
        ns_total, react, vel_step, dens_step = map(float, line.strip().split(', '))

        num_lines += 1
        sum_ns_total += ns_total
        sum_react += react
        sum_vel_step += vel_step
        sum_dens_step += dens_step

    mean_ns_total = sum_ns_total / num_lines
    mean_react = sum_react / num_lines
    mean_vel_step = sum_vel_step / num_lines
    mean_dens_step = sum_dens_step / num_lines

with open(sys.argv[1], 'a') as f:
    f.write(f"{mean_ns_total};;ns_per_cell_total;\n")
    f.write(f"{mean_react};;react;\n")
    f.write(f"{mean_vel_step};;vel_step;\n")
    f.write(f"{mean_dens_step};;dens_step;\n")
