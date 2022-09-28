module Helper

import IO;
import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;
import analysis::m3::Registry;
import lang::java::m3::Core;
import lang::java::m3::AST;
import util::Math;

void demoFunc() {
	list[str] output = [];
	m3x = createM3FromEclipseProject(|project://testProject|);
	registerProject(|project://testProject|, m3x);
	projectFiles = files(m3x);
	for(file <- projectFiles) {
	 	output = readFileLines(file);
	}
}

list[Declaration] getASTs(loc projectLocation){
	M3 model = createM3FromEclipseProject(projectLocation);
	list[Declaration] asts = [];
	for (m <- model.containment, m[0].scheme == "java+compilationUnit"){
		asts += createAstFromFile(m[0], true);
	}
	return asts;
}

set[loc] fileList (loc projectLoc) {
	m3x = createM3FromEclipseProject(projectLoc);
	return files(m3x);
}

list[str] projectToListString (loc projectLoc) {
	list[str] output = [];
	m3x = createM3FromEclipseProject(projectLoc);
	projectFiles = files(m3x);
	for(file <- projectFiles) {
		output += readFileLines(file);
	}
	return output;
}


list[str] getXElementsFrom(int index, int size, list[str] l) {
	list[str] res = [];
	for(n <- [0..size]) {
		res += l[index+n];
	};
	return res;
}

void printTable(map[int severity, real _] severity) {
	println("-----------------------------------");
	println("| Moderate |   High   | Very High |");
	println("-----------------------------------");
	buildNiceLine(severity);
	println("-----------------------------------");
}

void buildNiceLine(map[int severity, real _] severity) {
	list[int] spaces = [4,4,4];
	
	if(severity[1] >= 10) spaces[0] -= 1;
	if(severity[2] >= 10) spaces[1] -= 1;
	if(severity[3] >= 10) spaces[2] -= 1;
	
	for(int n <- [1..4]) {
		int valueX = round(severity[n]);
		print("|    <valueX>%");
		for(int _ <- [0..spaces[n-1]]) print(" ");
	}
	print(" |");
	println ("");

}