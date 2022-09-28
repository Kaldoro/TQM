module Analysis

import lang::java::m3::Core;
import lang::java::m3::AST;
import Helper;
import String;
import IO;
import UnitSize;

void main() {
	runAnalysis(|project://testProject|);
}

void runAnalysis(loc projectLoc) {
	prjFiles = fileList(projectLoc);
	
	//DO NOT FORGOT TO MAKE IT TEST FILES ONLY
	int unitS = unitSize(projectLoc);
	print(unitS);
}


lrel[str,loc] trimAndRemoveEmptyLinesAndComments(lrel[str text,loc location] lines){
	lrel[str,loc] out = [];
	bool inBlockComment = false;
	for (line <- lines){
		if (!inBlockComment){
			if(/^\s*$/ := line.text){ // whitespace
				continue;
			}
			else if(/^\/\/.*/ := line.text){ // <//> comments
				continue;
			}
			else if(/\/\*/ := line.text){ // start of /* comment
				if (/(\S+)(.*)(\/\*)|(\*\/)(.*)(\S+)/ := line.text){ // any non-whitespace before the /* or after the */ means this line counts as code
					out += <trim(line.text), line.location>;
				}
				inBlockComment = true;
			}
			else out += <trim(line.text), line.location>;
		}
		if(inBlockComment){ // This isnt <else if> because you might leave the blockComment on the same line as it started.
			if(/\*\// := line.text){
				inBlockComment = false;
			}
		}
	}
	
	return out;
}