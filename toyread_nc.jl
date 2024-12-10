using NCDatasets
using CSV, Tables, DataFrames

myds = NCDataset("ucblock/netCDF_files/UC_Data/T-Ramp/10_0_1_w.nc4")

blk0 = myds.group["Block_0"]

nbUnit = blk0.dim["NumberUnits"]
T = blk0.dim["TimeHorizon"]


println(nbUnit, " units")

ThUnits = [];
for ky in keys(blk0.group)
    if ( haskey(blk0.group[ky].attrib, "type") )
        if ( blk0.group[ky].attrib["type"] == "ThermalUnitBlock" )
            push!(ThUnits, ky)
        end
    end
end

#List of Thermal Units
println("The list of found Thermal units is as follows:")
println( ThUnits )

for ky in ThUnits
    println("Handling : ", ky)

    Pmin = blk0.group[ky]["MinPower"][]
    Pmax = blk0.group[ky]["MaxPower"][]
    println(Pmin, " ", Pmax)

end

# fonction de cout : quadterm * pi**2 + linearterm * pi + constterm
