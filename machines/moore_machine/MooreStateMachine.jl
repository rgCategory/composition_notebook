# DESCRIPTION: this module parses a wiring diagram from CatLab to implement a moore finite state machine. 

module MooreStateMachine

# Libraries
using AlgebraicDynamics
using AlgebraicDynamics.DWDDynam
using Catlab.WiringDiagrams
using Catlab.Graphics
using Catlab.Graphics.Graphviz

# Define machine
mutable struct MooreMachine
    diagram::WiringDiagram
    state_id::Int

    # Constructor
    function MooreMachine( diagram::WiringDiagram, initial_state::Any )                
        # Check initial state
        state_id = findall( box -> box.value == initial_state, boxes(diagram) )
        
        if isempty(state_id) == true
            error("Given state does not exist")
        else 
            new(diagram, state_id[1])  # Use first state that was found
        end
    end
end

# Update the state for a given an input
function eval_machine(machine::MooreMachine, input::Any)
    # Update state
    trans_input = boxes(machine.diagram)[machine.state_id].output_ports
    
    out_index = findall( x-> x == input, trans_input )
    if isempty(out_index) == true
        error("Input is not defined for state")
    else
        machine.state_id = out_wires(machine.diagram, machine.state_id)[ out_index[1] ].target.box   
    end
    
    # Readout state
    return boxes(machine.diagram)[machine.state_id].value
end

# Set the current state of a machine
function set_state(machine::MooreMachine, target_state::Any)
    # Find index of state
    id = findall( box -> box.value == target_state, boxes(machine.diagram) )
    
    # Check if state was found
    if isempty(id)
        error("Given state does not exist")
    else
        machine.state_id = id[1]
    end
end

# Information accesible by using module
export MooreMachine, eval_machine, set_state

end