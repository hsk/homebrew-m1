# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Gendev040 < Formula
  desc ""
  homepage ""
  depends_on "openjdk"
  if Hardware::CPU.arm?
    url "https://github.com/hsk/gendev-0.4.0/archive/refs/tags/0.4.0f.tar.gz"
    sha256 "6ab8b37ca26fdee1de6f222c3f55b61862237eb8aaf0faac97840d21e6853411"
    version "0.4.0"
  else
    system "false"
  end
  license "GPL-3.0-or-later" => { with: "GCC-exception-3.1" }

  bottle do
    root_url "https://github.com/hsk/brew-bottle/raw/main/gendev-0.4.0--0.4.0.arm64_big_sur.bottle.tar.gz"
    sha256 cellar: :any, arm64_big_sur: "98268987187df7a7b519104fdbdccc43c9249758230ec78681c509136f626cd1"
  end

  depends_on "make"
  depends_on "wget"
 
  def install

    system "echo #{prefix} #{lib}"
    system "GENDEV=#{prefix} make -j1"
    system "GENDEV=#{prefix} make -j1 install"
  end

  test do
    system "false"
  end
end
