export def --wrapped "pass insert" [...args: string] {
    ^pass insert ...$args
    $env.SSHPASS = (input -s "Enter ssh passphrase: ");
    rsync --rsh='sshpass -e -P assphrase ssh -l tetra' -vurt ~/.password-store/ tetraxile.dev:/home/tetra/password-store
    rsync --rsh='sshpass -e -P assphrase ssh -l tetra' -vurt tetraxile.dev:/home/tetra/password-store/ ~/.password-store
}

export def "pass sync" [] {
    $env.SSHPASS = (input -s "Enter ssh passphrase: ");
    rsync --rsh='sshpass -e -P assphrase ssh -l tetra' -vurt ~/.password-store/ tetraxile.dev:/home/tetra/password-store
    rsync --rsh='sshpass -e -P assphrase ssh -l tetra' -vurt tetraxile.dev:/home/tetra/password-store/ ~/.password-store
}
