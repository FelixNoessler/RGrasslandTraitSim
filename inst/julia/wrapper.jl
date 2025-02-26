function parameter_wrapper(parameter_names, parameter_values)
    keys_new_p = Symbol.(parameter_names)
    new_p_wo_units = (; zip(keys_new_p, parameter_values)...)
    new_p = GrasslandTraitSim.add_units(new_p_wo_units)

    p = GrasslandTraitSim.load_optim_result()
    simulation_keys = keys(GrasslandTraitSim.SimulationParameter())
    p_subset = NamedTuple{filter(x -> x ∈ simulation_keys && x ∉ keys_new_p, keys(p))}(p)

    return GrasslandTraitSim.SimulationParameter(; new_p..., p_subset...)
end


function solve_wrapper(plotID, p)
  trait_input = GrasslandTraitSim.input_traits()
  input_obj = GrasslandTraitSim.validation_input(plotID);
  prealloc = GrasslandTraitSim.preallocate_vectors(; input_obj);
  GrasslandTraitSim.solve_prob(; input_obj, p, trait_input, prealloc);
end

dim_array_to_array(d) = ustrip.(d.data)


