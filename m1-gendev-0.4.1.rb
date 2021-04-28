require 'benchmark'

class M1Gendev041 < Formula
  desc ""
  homepage ""
  depends_on "openjdk"
  if Hardware::CPU.arm?
    url "https://github.com/hsk/m1-gendev/archive/refs/tags/0.4.1.tar.gz"
    sha256 "a0b619b67087f588606d17b9ca6f86171a9bcaf856d855f9c76ff1a318ac8152"
  else
    system "false"
  end

  bottle do
    root_url "https://github.com/hsk/brew-bottle/raw/main"
    sha256 cellar: :any, arm64_big_sur: "cb94851231d7de1ab4d69035782fa7c62dd516c9654a5713222d1286667f7994"
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
