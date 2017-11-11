export PREFIX=/usr/local/cross
export TARGET=x86_64-elf
export MAKEFLAGS="-j 8"
mkdir -p ~/src/build-{binutils,gcc}/
curl ftp://ftp.gnu.org/gnu/binutils/binutils-2.29.tar.gz | tar -xvzf -C ~/src/
curl ftp://ftp.gnu.org/gnu/gcc/gcc-7.2.0/gcc-7.2.0.tar.gz | tar -xvzf -C ~/src/
curl ftp://ftp.gnu.org/gnu/gmp/gmp-6.1.2.tar.gz | tar -xvzf -C ~/src/gcc-7.2.0/
curl ftp://ftp.gnu.org/gnu/mpfr/mpfr-3.1.6.tar.gz | tar -xvzf -C ~/src/gcc-7.2.0/
curl ftp://ftp.gnu.org/gnu/mpc/mpc-1.0.3.tar.gz | tar -xvzf -C ~/src/gcc-7.2.0/
cd ~/src/build-binutils/
../binutils-2.29/configure --prefix=$PREFIX --target=$TARGET --disable-nls
make all
sudo make install
export PATH=$PATH:$PREFIX/bin
cd ~/src/build-gcc/
mv ../gcc-7.2.0/gmp-6.1.2/ ../gcc-7.2.0/gmp/
mv ../gcc-7.2.0/mpfr-3.1.6/ ../gcc-7.2.0/mpfr/
mv ../gcc-7.2.0/mpc-1.0.3/ ../gcc-7.2.0/mpc/
../gcc-7.2.0/configure --prefix=$PREFIX --target=$TARGET --disable-nls --without-headers --with-mpfr-include=$HOME/src/gcc-7.2.0/mpfr/src/ --with-mpfr-lib=$HOME/src/build-gcc/mpfr/src/.libs/
make all-gcc
sudo make install-gcc
