-- https://github.com/premake/premake-core/wiki

function genproject(proj, option)
	local proj_name = proj[1]
	local projoption = proj[2]
	if option['group'] then
		group (option['group'])
	end
	
	local proj_dir
	if projoption['projectdir'] then
		proj_dir = projoption['projectdir']
	else
		proj_dir = "SGI-STL Test/"..proj_name
	end
	
	project(proj_name)
		language "C++"
		implibdir "$(SolutionDir)../lib"
		objdir "$(SolutionDir)obj/%{prj.name}/%{cfg.platform}/%{cfg.buildcfg}"
		
		vpaths 
		{
			["Header Files"] = {"**.h", "**.hpp", "**.inc", "**.inl"},
			["Source Files"] = {"**.c", "**.cpp"},
		}
		
		if projoption['kind'] then
			kind (projoption['kind'])
		elseif option['kind'] then
			kind (option['kind'])
		else
			kind ("SharedLib")
		end
				
		defines { string.upper(proj_name).."_EXPORTS", string.upper(proj_name).."_LIB"}

		defines (option['defines'])
		defines (projoption['defines'])
		
		dependson (option['dependson'])
		dependson (projoption['dependson'])
		
		includedirs (option['includedirs'])
		includedirs (projoption['includedirs'])
		
		libdirs (option['libdirs'])
		libdirs (projoption['libdirs'])
		
		links (option['links'])
		links (projoption['links'])
		
		buildoptions (option['buildoptions'])
		buildoptions (projoption['buildoptions'])
		
		linkoptions (option['linkoptions'])
		linkoptions (projoption['linkoptions'])
		
		targetdir (option['targetdir'])
		targetdir (projoption['targetdir'])

		local target_name=proj_name
		if projoption['targetname'] then
			target_name =(projoption['targetname'])
		end
		filter "configurations:Debug"
			if option['static_flag'] then
				targetname(target_name..option['static_flag'].."d")
			else
				targetname(target_name.."d")
			end
			symbols "On"
			defines { "DEBUG", "_DEBUG" }
			defines(option['debugdefines'])
			defines(projoption['debugdefines'])
			links(option['debuglinks'])
			links(projoption['debuglinks'])
			libdirs(option['debuglibdirs'])
			libdirs(projoption['debuglibdirs'])
			runtime "Debug"
			
			if projoption['debugoptimize'] then
				optimize(projoption['debugoptimize'])
			elseif option['debugoptimize'] then
				optimize(option['debugoptimize'])
			else
				optimize "Off"
			end
			targetdir(option['debugtargetdir'])
			targetdir(projoption['debugtargetdir'])
		filter { }
	
		filter "configurations:Release" 
			targetname(target_name)
			defines { "NDEBUG"}
			symbols "On"
			optimize "Speed"
			defines(option['releasedefines'])
			defines(projoption['releasedefines'])
			links(option['releaselinks'])
			links(projoption['releaselinks'])
			libdirs(option['releaselibdirs'])
			libdirs(projoption['releaselibdirs'])
			runtime "Release"
			targetdir(option['releasetargetdir'])
			targetdir(projoption['releasetargetdir'])
		filter { }
		
		filter { "platforms:Win32" }
			architecture "x86"
			libdirs(option['x86libdirs'])
			libdirs(projoption['x86libdirs'])
		filter {}
		
		filter { "platforms:x64" }	
			architecture "x86_64"
			libdirs(option['x64libdirs'])
			libdirs(projoption['x64libdirs'])
		filter {}
		
		filter { "Debug", "platforms:Win32" }
			libdirs(option['x86debuglibdirs'])
			libdirs(projoption['x86debuglibdirs'])
		filter { }
		
		filter { "Release", "platforms:Win32"}
			libdirs(option['x86releaselibdirs'])
			libdirs(projoption['x86releaselibdirs'])
		filter { }
		
		filter { "Debug", "platforms:x64" }
			libdirs(option['x64debuglibdirs'])
			libdirs(projoption['x64debuglibdirs'])
		filter { }
		
		filter { "Release", "platforms:x64"}
			libdirs(option['x64releaselibdirs'])
			libdirs(projoption['x64releaselibdirs'])
		filter { }
		
		includedirs
		{
			"./"..proj_dir,
		}
		
		files {
			proj_dir.."/**.h",
			proj_dir.."/**.hpp",
			proj_dir.."/**.inl",
			proj_dir.."/**.cpp",
		}
		
		if projoption['files'] then
			files (projoption['files'])
		end
		
		libdirs
		{
			"$(SolutionDir)../lib",
		}
		
		if projoption['excludes'] then
			excludes (projoption['excludes'])
		end
end 
	
function genprojects(proj_list, option)
	for i=1,#proj_list do
		genproject (proj_list[i], option)
	end
end