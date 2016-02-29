class Patchelf < Formula
  desc "PatchELF: modify the dynamic linker and RPATH of ELF executables"
  homepage "https://nixos.org/patchelf.html"
  # tag "linuxbrew"

  url "http://nixos.org/releases/patchelf/patchelf-0.9/patchelf-0.9.tar.gz"
  sha256 "f2aa40a6148cb3b0ca807a1bf836b081793e55ec9e5540a5356d800132be7e0a"

  bottle do
    cellar :any
    sha256 "40eb31a429ae5d81f1f13999663d9f87099bb11d65273691642429c5d525132e" => :x86_64_linux
  end

  head do
    url "https://github.com/NixOS/patchelf.git"
    depends_on "autoconf" => :build
    depends_on "automake" => :build
  end

  option "with-static", "Link statically"
  option "without-static-libstdc++", "Link libstdc++ dynamically"

  def install
    system "./bootstrap.sh" if build.head?
    system "./configure", "--prefix=#{prefix}",
      if build.with?("static") then "CXXFLAGS=-static"
      elsif build.with?("static-libstdc++") then "CXXFLAGS=-static-libgcc -static-libstdc++"
      end,
      "--disable-debug", "--disable-dependency-tracking", "--disable-silent-rules"
    system "make", "install"
  end

  def post_install
    # Fix up binutils after glibc and patchelf are installed.
    # Fix ld: liblto_plugin.so: error loading plugin: /lib64/libc.so.6: version `GLIBC_2.7' not found
    binutils = Formula["binutils"]
    if binutils.installed? && Formula["glibc"].installed?
      ohai "Fixing up #{binutils.full_name}..."
      keg = Keg.new binutils.prefix
      keg.relocate_install_names Keg::PREFIX_PLACEHOLDER, HOMEBREW_PREFIX,
        Keg::CELLAR_PLACEHOLDER, HOMEBREW_CELLAR
    end
  end

  test do
    system "#{bin}/patchelf", "--version"
  end
end
