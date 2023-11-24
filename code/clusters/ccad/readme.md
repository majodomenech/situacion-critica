# Comandos útiles

## `seff`

This command is used as

		seff <job-id>
		
and will tell how efficiently your job used the computational resources.

* [https://hpc.nmsu.edu/discovery/slurm/job-management/](https://hpc.nmsu.edu/discovery/slurm/job-management/)

## `sacct`

To get a list of all job IDs for your completed jobs, you can use the following command:

		sacct --format=JobID,State --state=COMPLETED -u your_username

Replace your_username with your actual username. This command will display the Job ID and State (which should be "COMPLETED" for completed jobs) for all your completed jobs.

If you want more detailed information about the completed jobs, you can customize the --format option to include additional fields. For example:

bash

		sacct --format=JobID,JobName,State,Elapsed -u your_username

This command will display the Job ID, Job Name, State, and Elapsed time for all your jobs.

Feel free to customize the --format and other options according to your specific needs. You can find more information about the sacct command and its options in the Slurm documentation.

