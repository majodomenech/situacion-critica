### El siguiente script, cortesía de Nahuel Almeira, sirve para paralelizar trabajos de manera trivial. Es decir, corre 2500 procesos independientes ocupando de a 8 núcleos a la vez, reservados de un dado nodo. Más precisamente, llama a "miscript.sh" con los argumentos i 10 XYZ, donde i es el i-esimo elemento de $(seq 1 2500). Este i puede usarse para alimentar con los parametros de entrada que sean necesarios a cada uno de los 2500 procesos. Notar que el parámetro -P 8 de xargs sirve para mantener corriendo de a 8 procesos a la vez (ni más, ni menos). De esta manera, cuando el i-ésimo termina (o se cae), xargs lanza el (i+1)-esimo, y así hasta completar los 2500 indicados. Naturalmente, podemos modificar el 8 por la cantidad de núcleos que consideremos conveniente y que el nodo permita.
### El script es de caracter general. Faltaría generar una versión adaptada a cada cluster del CCAD. Por ejemplo, este script no especifica la partición donde deberían correrse los procesos. No se si faltaría alguna cosa más.

#!/bin/bash
#SBATCH --time=4-00:00:00
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
. /etc/profile
srun echo $(seq 1 2500) | xargs -P 8 -n 1 bash miscript.sh 10 XYZ
