// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "drosera-contracts/interfaces/ITrap.sol";

interface IERC20 {
    function allowance(address owner, address spender) external view returns (uint256);
}

/**
 * @title AllowanceSpikeTrap_Custom
 * @notice Allowance spike detector with parameters pre-filled per request.
 *
 * TOKEN   : 0x499b095Ed02f76E56444c242EC43A05F9c2A3ac8
 * OWNER   : 0x216a54E8bFD7D9bB19fCd5730c072F61E1Af2309
 * SPENDER : 0x8164139a6aA30944D991e67A09bbdf2cb96E8b80
 * THRESHOLD: 100 tokens (100 * 10^18 to account for decimals)
 */
contract AllowanceSpikeTrap_Custom is ITrap {
    address public constant TOKEN   = 0x499b095Ed02f76E56444c242EC43A05F9c2A3ac8;
    address public constant OWNER   = 0x216a54E8bFD7D9bB19fCd5730c072F61E1Af2309;
    address public constant SPENDER = 0x8164139a6aA30944D991e67A09bbdf2cb96E8b80;
    uint256 public constant THRESHOLD = 100 * 10**18;

    string public constant trapName = "AllowanceSpikeTrap_Custom_v1";

    constructor() {
        require(TOKEN != address(0), "zero token");
        require(OWNER != address(0), "zero owner");
        require(SPENDER != address(0), "zero spender");
    }

    function collect() external view returns (bytes memory) {
        uint256 currentAllowance = IERC20(TOKEN).allowance(OWNER, SPENDER);
        return abi.encode(currentAllowance, TOKEN, OWNER, SPENDER, trapName);
    }

    function shouldRespond(bytes[] calldata data) external pure returns (bool, bytes memory) {
        if (data.length == 0) return (false, bytes(""));

        (uint256 allowanceValue, address token, address owner, address spender, string memory name) =
            abi.decode(data[0], (uint256, address, address, address, string));

        bool willRespond = allowanceValue > 0 && allowanceValue > THRESHOLD;

        if (willRespond) {
            string memory reason = string(
                abi.encodePacked(
                    "allowance_above_threshold; threshold=",
                    uint2str(THRESHOLD)
                )
            );
            bytes memory payload = abi.encode(allowanceValue, token, owner, spender, reason);
            return (true, payload);
        }

        return (false, bytes(""));
    }

    function uint2str(uint256 _i) internal pure returns (string memory str) {
        if (_i == 0) return "0";
        uint256 j = _i;
        uint256 len;
        while (j != 0) {
            len++;
            j /= 10;
        }
        bytes memory bstr = new bytes(len);
        j = _i;
        while (j != 0) {
            bstr[--len] = bytes1(uint8(48 + j % 10));
            j /= 10;
        }
        str = string(bstr);
    }
}
