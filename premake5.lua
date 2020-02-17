dofile("modules/function.lua")

flags 
{
	"MultiProcessorCompile"
}

local build_location = "build-".._ACTION
workspace "sgistltest"
	location(build_location)
	targetdir "bin"
	configurations {"Debug", "Release"}
	platforms { "Win32", "x64"}
	
	filter "system:Windows"
      systemversion "latest" -- To use the latest version of the SDK available
	 
	includedirs {
		"SGI-STL V3.3"
	}

local projs = {
	{
		"adapter_test", {}
	},
	{
		"algorithm_test", {}
	},
	{
		"allocator_test", {}
	},
	{
		"container_test", {}
	},
	{
		"functor_test", {}
	},
	{
		"iterator_test", {}
	}
}

genprojects(projs, {['kind'] = "ConsoleApp"})