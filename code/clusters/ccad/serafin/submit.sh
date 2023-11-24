#!/bin/bash

#SBATCH --job-name=karate_8192

#SBATCH --output=output_sf_karate_8192.log

#SBATCH --partition=multi

#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=32

#SBATCH --exclusive

#SBATCH --mail-type=begin
#SBATCH --mail-type=end
#SBATCH --mail-user=nicolasvazquez.vonbibow@mi.unc.edu.ar

srun julia -t 32 karate_Ns8192.jl