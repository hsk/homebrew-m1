require 'benchmark'

class M1Gendev051 < Formula
  desc ""
  homepage ""
  depends_on "openjdk"
  if Hardware::CPU.arm?
    url "https://github.com/hsk/m1-gendev/archive/refs/tags/0.5.1.tar.gz"
    sha256 "86a6e9d9c71a069f2d5158b64b8c37aaa0ff0cbfc996220fc81be1304d7694dd"
  else
    system "false"
  end

  bottle do
    root_url "https://github.com/hsk/brew-bottle/raw/main"
    sha256 cellar: :any, arm64_big_sur: "9c2bf85c7868804f5b4be05c919d9262e79a7865f7850e6f357f8dc6d57c7b57"
  end

  depends_on "make"
  depends_on "gendev-gcc"
  depends_on "wget"
  def sys p
    puts Benchmark.measure { system p }
  end
  def install
    mkdir "./build"
    pre = Formula["gendev-gcc"].prefix
    sys "cp -rf #{pre}/* ./build/.\n"
    sys "GENDEV=#{prefix} make -j1 tools_build"
    sys "GENDEV=#{prefix} make -j1 sgdk_build"
    sys "GENDEV=#{prefix} make install"
  end

  def caveats
    <<~EOS
      Before you can use these tools you must export some variables to your $SHELL.
      export GENDEV=#{prefix}
    EOS
  end


  test do
    system "false"
  end
end
