local function includeFile(_file)
{
	::MSU.includeFile("msu/systems/tooltips/", _file);
}

includeFile("tooltips_system");
::MSU.System.Tooltips <- ::MSU.Class.TooltipsSystem();
includeFile("tooltips_mod_addon");
includeFile("abstract_tooltip");
::MSU.includeFiles(::IO.enumerateFiles("msu/systems/tooltips/tooltips"));
