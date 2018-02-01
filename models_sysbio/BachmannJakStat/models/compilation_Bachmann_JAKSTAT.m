try
    rmdir /Users/carolinloos/PhD/Software/AMICIGit/models/Bachmann_JAKSTAT
catch
end
try
    rmdir /home/icb/carolin.loos/PhD/AMICIGit/models/Bachmann_JAKSTAT
catch
end
try
    rmdir /Users/carolinloos/PhD/Software/AMICIGit/models/Bachmann_JAKSTAT_SHP1oe
catch
end
try
    rmdir /home/icb/carolin.loos/PhD/AMICIGit/models/Bachmann_JAKSTAT_SHP1oe
catch
end

[exdir,~,~]=fileparts(which('Bachmann_JAKSTAT_syms.m'));
amiwrap('Bachmann_JAKSTAT','Bachmann_JAKSTAT_syms',exdir)
amiwrap('Bachmann_JAKSTAT_SHP1oe','Bachmann_JAKSTAT_SHP1oe_syms',exdir)