# Natural Language contracts - UAV

A contract ensures a specific output so long as the inputs meet certain conditions.

__1. Sensor angle:__  

- _Justification:_ The estimated pitch angle is a low-pass filtered value of the actual angle. Under this restriction the amplitude of the sensor is always smaller or equal than the actual value. At steady state both angles will match. See Figure 1 (Kamenetsky, p. 1). 

<p align="center"> <img src ="https://raw.githubusercontent.com/rgCategory/composition_notebook/main/images/contract/first_order_low_pass.png" width="70%"> </p>
<p align="center"> Figure 1. Magnitude response of 1rst order low-pass filter </p>

- _Inputs:_ The physical pitch of the aircraft. The angle must be within 90° of the horizon. The pitch angle offset must not exceed the maximum climb angle of the aircraft while also being a valid angle: 

<p align="center"> |θ| < 90° AND -90° < e < 20° </p>  

- _Outputs:_ The magnitude of the measured angle will be smaller or equal to the actual angle: 
<p align="center"> |sᶜ| ≤ |θ| </p>  

__2. Controller output:__ 

- _Justification:_ For large reynolds numbers, elevator deflections greater than 15° will cause flow seperation (stall) across the flap. Large enough deflections will also cause the wing to stall at steady state. At the same time, the target angle cannot exceed the maximum climb angle as the aircraft cannot sustain this condition. The controller can prevent these situations from occuring by restricting the inputs. See Figure 2 (Hoerner, p. 5-5). 

<p align="center"> <img src ="https://raw.githubusercontent.com/rgCategory/composition_notebook/main/images/contract/flap_angle.png" width="50%"> </p>   
<p align="center"> Figure 2. Change in lift coefficient with flap deflection </p>

The deflection that causes steady-state stall can be calculated using the dynamics equations. This is accomplish by setting the derivative terms to zero (steady-state) and solving for the angle of attack α as a function of the deflection 𝛿:

<p align="center"> 0 = A₁₁α + A₁₂q + B₁𝛿 </p>
<p align="center"> 0 = A₂₁α + A₂₂q + B₂𝛿 </p> 

Solving for q/𝛿 and α/𝛿 yield:
<p align="center"> q/𝛿 = (B₂/A₁₂ - B₁/A₁₁)(A₂₂/A₁₂ - A₂₁/A₁₁)⁻¹ </p> 
<p align="center"> α/𝛿 = A₂₁(B₂/A₁₂ - B₁/A₁₁)/(A₂₂ - A₂₁) - B₁/A₁₁ </p>
 
Making the appropriate substitutions results in:

<p align="center"> q = 0.0033958 𝛿 </p> 
<p align="center"> α = 1.35636 𝛿 </p> 

Solving for 𝛿 at an angle of attack of 15° gives the elevator deflection that causes stall:

<p align="center"> 𝛿 = (15 π/180)/1.35636 = 0.193020 rad = 11.059° </p> 

- _Inputs:_ The sensor signal and the target input. Their combiled value will be smaller than the stall angle of the flap and will not cause the wing to stall. The target pitch angle will also not exceed the maximum climb angle: 

<p align="center"> |sᴸ - d| < 11.059° AND d < 20° </p>   

__NOTE:__ 15° > 11.059° > d hence the input is limited by the stall angle of the flap.  

- _Outputs:_ A flap deflection which prevents the wing and the elevator from stalling: 

<p align="center"> |𝛿| < 15° and |α| < 15° </p> 

__3. Angle of attack:__ 

- _Justification:_ The angle of attack cannot exceed the stall angle of the wing. However this threshold changes with the geometry of the aircraft. In general this occurs at around 15° for large reynolds numbers. See Figure 3 (Hoerner, p. 3-6). 

<p align="center"> <img src ="https://raw.githubusercontent.com/rgCategory/composition_notebook/main/images/contract/stall_angle.png" width="50%"> </p>  
<p align="center"> Figure 3. Lift coefficient vs angle of attack for rectangular wing </p>

- _Inputs:_ This term accepts all inputs as simply reacts to them.

- _Outputs:_ The angle of attack will not exceed the stall angle of the wing: 
<p align="center"> |α| < 15° </p> 

__4. Pitch rate:__ 

- _Justification:_ The maximum value is determined by the elevator deflection. Underdamped motion will cause overshoot and the pitch rate will momentarily exceed its steady state value. In spite of this there are no adverse effects to having a large angular velocity. 

- _Inputs:_ This term accepts all inputs as simply reacts to them.

- _Outputs:_ There are no restrictions.

__5. Pitch angle:__ 

- _Justification:_ The maximum pitch angle in steady-state flight is dictated by the maximum rate of climb of the aircraft. This is determined by the excesss thrust the vehicle can produce while in flight. In manned aircraft this angle rarely exceeds 20°. See Figure 4 (Sadraey, p. 325). 

<p align="center"> <img src ="https://raw.githubusercontent.com/rgCategory/composition_notebook/main/images/contract/pitch_angle.png" width="70%"> </p>  
<p align="center"> Figure 4. Rate of climb and pitch angle for a typical piston-prop aircraft </p>
    
- _Inputs:_ This term accepts all inputs as simply reacts to them.

- _Outputs:_ The pitch angle will not exceed the maximum climb angle. Likewise, the pitch angle must lie within 90° to be reasonable.     
<p align="center"> - 90° < θ < 20° </p>

__6. Collision avoidance:__ 

- _Justification:_ The aircraft must avoid colliding with objects it encounders. 
These can be static objects like the ground or moving objects like other aircraft. 
As the aircraft has a minimum turn radius the obstacles must be sufficiently far away to avoid a collision. 
This minimum turn radius is dictated by the stall angle as it restricts the maximum centripetal acceleration of the aircraft (Sadraey, p. 414). 
By assuming the aircraft's trajectory is circular one can determine the turn radius with the angular and linear velocity:
<p align="center"> r = V/ω </p>

The maximum angular velocity at steady state can be found by from the dynamics equations. Combining the solutions for steady-state and making the appropriate substitutions with α = 15° yields:

<p align="center"> q = 0.0033958 𝛿 </p>
<p align="center"> 𝛿 = α/1.35636 </p>
<p align="center"> θ' = 56.7 q </p>
<p align="center">	→ θ' = ω = 0.0372062 rad/s </p>

The minimum distance __d__ at which the aircraft can avoid an obstancle of radius __R__ can be found through geometry. See Figure 5.

<p align="center"> <img src ="https://raw.githubusercontent.com/rgCategory/composition_notebook/main/images/collision_diagram.png" width="25%"> </p>  
<p align="center"> Figure 5. Collision triangle </p>

Through the hypotenuse of the triangle one can find the collision distance. Expading and cancelling terms then substituting __r__ yields:
<p align="center"> d² + r² = (r + R)² </p>
<p align="center"> → dₘᵢₙ = √( 2R(V/ω) + R) </p>

- _Inputs:_ The position and orientation of the obstacle and the UAV along with the obstacle's radius. There are no restrictions on the position and orientation as they're dictated by external factors. However the radius must be greater than zero to represent a valid obstacle. At the same time the collision distance cannot be smaller than the minimum value: 
<p align="center"> R > 0 AND d > dₘᵢₙ </p>   

- _Outputs:_ A control deflection that ensures the aircraft does not fly into the region of the obstacle. That is, the distance between the aircraft and the obstacle will be greater than the radius of the obstacle:
<p align="center"> r > R </p>     

__->pending:__ contracts that might span two UAVs flying collaboratively

## References:  
    
Hoerner, S. F., & Borst, H. V. (1985). Fluid-dynamic lift: Practical information on aerodynamic and hydrodynamic lift. Alburquerque, N.M: Hoerner Fluid Dynamics. 

Sadraey, Mohammad H. (2017). Aircraft Performance. Boca Raton: CRC Press.   

Kamenetsky, M. (2013). Filtered audio demo. Course Notes: EE102.  
