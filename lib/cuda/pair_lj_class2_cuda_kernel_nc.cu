/* ----------------------------------------------------------------------
   LAMMPS - Large-scale Atomic/Molecular Massively Parallel Simulator

   Original Version:
   http://lammps.sandia.gov, Sandia National Laboratories
   Steve Plimpton, sjplimp@sandia.gov

   See the README file in the top-level LAMMPS directory.

   -----------------------------------------------------------------------

   USER-CUDA Package and associated modifications:
   https://sourceforge.net/projects/lammpscuda/

   Christian Trott, christian.trott@tu-ilmenau.de
   Lars Winterfeld, lars.winterfeld@tu-ilmenau.de
   Theoretical Physics II, University of Technology Ilmenau, Germany

   See the README file in the USER-CUDA directory.

   This software is distributed under the GNU General Public License.
------------------------------------------------------------------------- */

__device__ inline F_FLOAT PairLJClass2Cuda_Eval(const F_FLOAT &rsq, const int ij_type, F_FLOAT &factor_lj, int &eflag, ENERGY_FLOAT &evdwl)
{
  const F_FLOAT r2inv = F_F(1.0) / rsq;
  const F_FLOAT r6inv = r2inv * r2inv * r2inv;
  const F_FLOAT r3inv = _SQRT_(r6inv);

  if(eflag) evdwl += factor_lj * (r6inv * (_lj3[ij_type] * r3inv -
                                    _lj4[ij_type]) - _offset[ij_type]);

  return factor_lj * r6inv * (_lj1[ij_type] * r3inv - _lj2[ij_type]) * r2inv;
}

