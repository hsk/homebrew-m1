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
