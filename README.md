# orbits

A collection of utils and scripts to compute and visualize orbits. 


## Orbit Mechanics Labs
Practical exercises supporting the lecture (ESPACE 22/23, TUM)

### Keplerian Orbits in Space-fixed, Earth-fixed and Topocentric Systems
Orbits of GOCE, GPS, Molniya, Michibiki and a GEO satellite visualized as
- 3D in space fixed system
- 3D in earth fixed system
And resulting 
- groundtracks
- satellite visibility from Wettzell
<details>
  <summary>Image results</summary>
 <table>
  <tr>
    <td> <img src="results/3D_orbit.png" height=300> </td>
    <td> <img src="results/efix_3d.png" height=300> </td>
  </tr>
  <tr>
    <td> <img src="results/ground_tracks.png" height=300> </td>
    <td> <img src="results/skyplot.png" height=300> </td>
  </tr>
</table> 
</details>

### Numerical Integration of Satellite Orbits
Analysis of errors introduced by numberical integration of Sentinel-3.
<details>
  <summary>Image results</summary>
 <table>
  <tr>
    <td> <img src="results/pos_undist_RSW_3x2.png" height=300> </td>
    <td> <img src="results/pos_dist_RSW_3x2.png" height=300> </td>
  </tr>
  <tr>
    <td> <img src="results/vel_undist_3x2.png" height=300> </td>
    <td> <img src="results/vel_dist_3x2.png" height=300> </td>
  </tr>
</table> 
</details>

## Advanced Orbit Mechanics Labs
Practical exercises supporting the lecture (ESPACE 23, TUM)

### TerraSAR & Tandem-X: Relative Motion and Hill Equations
<img src="results/difference_hill_relative_orbit.png" height=300>
<details>
  <summary>Further results</summary>
 <table>
  <tr>
    <td> <img src="results/motion_around_tSAR.png" height=300> </td>
    <td> <img src="results/motion_around_tSAR_from_hill.png" height=300> </td>
  </tr>
  <tr>
    <td colspan=2> <img src="results/position_diff_inert.png" height=400> </td>
  </tr>
</table> 
</details>

### Integration of Satellite Orbits with Different Force Models
Analysis of the influence of common perturbations on satellites of different height, i.e. GRACE and Galileo.
<img src="results/_summary_nOrderSunMoonGalileo.png" height=300>
<details>
  <summary>Further results</summary>
 <table>
  <tr>
    <td> <img src="results/rAC.png" height=300> </td>
    <td> <img src="results/rCH.png" height=300> </td>
  </tr>
  <tr>
    <td> <img src="results/rAC_orb.png" height=300> </td>
    <td> <img src="results/rCH_orb.png" height=300> </td>
  </tr>
</table> 
</details>