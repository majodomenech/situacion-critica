#!/bin/bash

#SBATCH --job-name=mi-script
#SBATCH --output=mi-script.log
#SBATCH --partition=multi
#SBATCH --exclusive

#SBATCH --time=2-00:00:00
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=64

#SBATCH --mail-type=begin
#SBATCH --mail-type=end
#SBATCH --mail-user=juan.perez@mi.unc.edu.ar


### El siguiente script, cortesía de Nahuel Almeira, sirve para paralelizar trabajos de manera trivial. Es decir, corre 2500 procesos independientes ocupando de a 64 núcleos a la vez, reservados de un dado nodo. Más precisamente, llama a "mi-script.jl" con los argumentos i v1 v2, donde i es el i-esimo elemento de $(seq 1 2500). Este i puede usarse para alimentar con los parametros de entrada que sean necesarios a cada uno de los 2500 procesos. Notar que el parámetro -P 64 de xargs sirve para mantener corriendo de a 64 procesos a la vez (ni más, ni menos). De esta manera, cuando el i-ésimo termina (o se cae), xargs lanza el (i+1)-esimo, y así hasta completar los 2500 indicados. Naturalmente, podemos modificar el 64 por la cantidad de núcleos que consideremos conveniente y que el nodo permita.
### El script es de caracter general. Faltaría generar una versión adaptada a cada cluster del CCAD. Por ejemplo, este script no especifica la partición donde deberían correrse los procesos. No se si faltaría alguna cosa más.

. /etc/profile

#srun julia mi-script.jl
#srun echo $(seq 1 2500) | xargs -P 64 -n 1 mi-executable.o v1 v2
#srun echo $(seq 1 2500) | xargs -P 64 -n 1 bash mi-script.sh v1 v2
srun echo $(seq 1 2500) | xargs -P 64 -n 1 julia mi-script.jl v1 v2
