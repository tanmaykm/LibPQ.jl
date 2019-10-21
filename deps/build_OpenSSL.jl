products = [
    LibraryProduct(prefix, ["libcrypto"], :libcrypto),
    LibraryProduct(prefix, ["libssl"], :libssl),
]

# Download binaries from hosted location
bin_prefix = "https://github.com/JuliaBinaryWrappers/OpenSSL_jll.jl/releases/download/OpenSSL-v1.1.1%2B0"

# Listing of files generated by BinaryBuilder:
download_info = Dict(
    Linux(:aarch64, libc=:glibc) => ("$bin_prefix/OpenSSL.v1.1.1+c.aarch64-linux-gnu.tar.gz", "afaac1c4f8388fbc4b5e6b02ef2084e58654b16510bac756d4fa8bd693b84f9e"),
    Linux(:aarch64, libc=:musl) => ("$bin_prefix/OpenSSL.v1.1.1+c.aarch64-linux-musl.tar.gz", "9bdccf83afa75e4c82379d9ce591c48a4da975daad78fac436f174a9cb1a1486"),
    Linux(:armv7l, libc=:glibc, call_abi=:eabihf) => ("$bin_prefix/OpenSSL.v1.1.1+c.arm-linux-gnueabihf.tar.gz", "e11c47d1f05bee82e086f03a299b4837fe4aba35661c8af9c36ba2125049f7bd"),
    Linux(:armv7l, libc=:musl, call_abi=:eabihf) => ("$bin_prefix/OpenSSL.v1.1.1+c.arm-linux-musleabihf.tar.gz", "86fca6c56d619f65dcdaf453dbd31701c2937e1407fc686ed3471b046610b88c"),
    Linux(:i686, libc=:glibc) => ("$bin_prefix/OpenSSL.v1.1.1+c.i686-linux-gnu.tar.gz", "e6620ac75d424246434f2fe24021e61fea92d239318a7b04deead3a234b8f978"),
    Linux(:i686, libc=:musl) => ("$bin_prefix/OpenSSL.v1.1.1+c.i686-linux-musl.tar.gz", "ef63d029419bd00ff6010f412f1f56fc281d22c73f04ca2253e3ed131ff45323"),
    Windows(:i686) => ("$bin_prefix/OpenSSL.v1.1.1+c.i686-w64-mingw32.tar.gz", "6cf6c7cde07a62befb871fc8c79eb97864d9da9fcb1d96043ce492dc84902938"),
    Linux(:powerpc64le, libc=:glibc) => ("$bin_prefix/OpenSSL.v1.1.1+c.powerpc64le-linux-gnu.tar.gz", "a76e22af9dcd9e108ea2025eff0dbcd6382b97a170a0c6a777fb16c7250edb4c"),
    MacOS(:x86_64) => ("$bin_prefix/OpenSSL.v1.1.1+c.x86_64-apple-darwin14.tar.gz", "e03a6b5b396462df2ae82a87b03b9f186f32b75a4277a1a284f0584a79b22840"),
    Linux(:x86_64, libc=:glibc) => ("$bin_prefix/OpenSSL.v1.1.1+c.x86_64-linux-gnu.tar.gz", "0628df28f09c29e87e07747b81319e0ca839b9ff54059a7db35acfe3b4641be4"),
    Linux(:x86_64, libc=:musl) => ("$bin_prefix/OpenSSL.v1.1.1+c.x86_64-linux-musl.tar.gz", "dc3fe9c3c1375674f13fe98aa3d684eb10682450945759108df778f622a7955f"),
    FreeBSD(:x86_64) => ("$bin_prefix/OpenSSL.v1.1.1+c.x86_64-unknown-freebsd11.1.tar.gz", "53544564caf3c0301b424c36d579aed408695bbef1e51f95856d7093cb6c694d"),
    Windows(:x86_64) => ("$bin_prefix/OpenSSL.v1.1.1+c.x86_64-w64-mingw32.tar.gz", "d11e5d7a90d3e2024809bef0f31d12d56c436327eb4bb7d6684baa709c5dbcb1"),
)

# Install unsatisfied or updated dependencies:
if any(!satisfied(p; verbose=verbose) for p in products)
    try
        # Download and install binaries
        url, tarball_hash = choose_download(download_info)
        install(url, tarball_hash; prefix=prefix, force=true, verbose=true)
    catch e
        if typeof(e) <: ArgumentError
            error("Your platform $(Sys.MACHINE) is not supported by this package!")
        else
            rethrow(e)
        end
    end

    # Finally, write out a deps.jl file
    # this is never used but will catch some failures
    write_deps_file(joinpath(@__DIR__, "deps_OpenSSL.jl"), products)
end
