compile:
    #!/usr/bin/env bash
    set -euxo pipefail
    cd token-deployer
    npx hardhat compile

deploy:
    #!/usr/bin/env bash
    set -euxo pipefail
    cd token-deployer
    npx hardhat run --network mumbai scripts/deploy.ts

