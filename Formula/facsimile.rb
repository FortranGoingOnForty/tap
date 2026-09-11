class Facsimile < Formula
  desc "Terminal text editor written in Fortran with VSCode-style keybindings"
  homepage "https://github.com/FortranGoingOnForty/facsimile"
  url "https://github.com/FortranGoingOnForty/facsimile/archive/refs/tags/v0.42.0.tar.gz"
  sha256 "dd1a449580fc21605e7086e37ff118bce6e93b7b6a6b9b2edebc9c7706f34e74"
  license "MIT"
  head "https://github.com/FortranGoingOnForty/facsimile.git", branch: "trunk"

  depends_on "gcc" # for gfortran

  def install
    # Pin the compiler to the GCC dependency. On Apple silicon, allowing Make
    # to discover another Fortran compiler can produce a binary that aborts on
    # deferred-length character assignment in the command palette.
    system "make", "FC=#{formula_opt_bin("gcc")}/gfortran"

    # Install binary
    bin.install "fac"

    # Create symlink for convenience
    bin.install_symlink "fac" => "facsimile"

    # Install documentation
    doc.install "README.md"
  end

  test do
    assert_match "fac version #{version}", shell_output("#{bin}/fac --version 2>&1")
    assert_match "libgfortran", shell_output("otool -L #{bin}/fac") if OS.mac?
  end
end
