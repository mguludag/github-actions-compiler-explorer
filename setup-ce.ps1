git clone https://github.com/compiler-explorer/compiler-explorer.git


$installDir = vswhere -latest -products * -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64 -property installationPath
if ($installDir) {
  $path = join-path $installDir 'VC\Auxiliary\Build\Microsoft.VCToolsVersion.default.txt'
  if (test-path $path) {
    $version = gc -raw $path
    if ($version) {
      $version = $version.Trim()
      $path = join-path $installDir "VC\Tools\MSVC\$version"
      echo $path
      # Define the file path
	  
	  $cpp_local_props = @"
# replace with the result of `echo %INCLUDE%`
# if you want a specific includePath for a specific compiler,
# you can set it up in that compiler's config, with, say
# compiler.my_clang.includePath=path_to_libc++

includePath=$path\include

libPath=$path\lib\x64



# replace with the result of `where undname.exe` from a developer command prompt

demangler=$path\bin\Hostx64\x64\undname.exe


# the compiler you want compiler explorer to start up in

defaultCompiler=vc2022_64

supportsBinary=true
supportsExecute=true


# note: adding new compiler groups
# the default compiler groups should be fine for most,
# but if you'd like to add more groups
# (for example, for vc 2015, or for gcc),
# you can uncomment and edit the following lines.
# check `c++.win32.properties` for how to modify the group options

compilers=&vc2022:&clang

group.vc2022.compilers=vc2022_64
group.vc2022.options=-EHsc
group.vc2022.compilerType=win32-vc
group.vc2022.needsMulti=false
group.vc2022.includeFlag=/I
group.vc2022.versionFlag=/?
group.vc2022.versionRe=^.*Microsoft \(R\).*$
group.vc2022.groupName=Visual Studio MSVC




# clang compilers
# if you want more compilers, you can do that by separating the names with `:`
# and then setting up a compiler.my_clang.exe and compiler.my_clang.name

group.clang_64.compilers=clang_64


# this is the default path that clang++ is installed in
# if you installed it somewhere else, you should edit both variables

compiler.clang_64.exe=C:\Program Files\LLVM\bin\clang++.exe
compiler.clang_64.name=clang amd64

# visual C++ 2022 compilers
# follow the same instructions as for clang
# note that if CE doesn't find a compiler, it won't break anything

group.vc2022_64.compilers=vc2022_64


# these are pointed at my own installation;
# you'll likely have to change the paths for your own machine


compiler.vc2022_64.exe=$path\bin\Hostx64\x64\cl.exe
compiler.vc2022_64.name=VC 2022 amd64
compiler.vc2022_64.libPath=&libPath64
compiler.vc2022_64.ldPath=&libPath64
"@
      Out-File -FilePath $pwd/compiler-explorer/etc/config/c++.local.properties -InputObject $cpp_local_props -Encoding ascii
    }
  }
}


cd $pwd/compiler-explorer
npm install
npm install webpack -g
npm install webpack-cli -g
npm update webpack
npm start


