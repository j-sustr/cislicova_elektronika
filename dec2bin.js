
22

let bin = dec2bin(2147483647);

console.log(parseInt(bin, 2))

console.log(2**32 / 2)


/**
 * Cislo dec muze byt max 2147483647.
 * @param {*} dec 
 */
function dec2bin(dec) {
    let remainder = 0;
    let fraction = Math.abs(dec);
    
    const binDigits = [];

    while (fraction > 0) {
        remainder = fraction % 2;
        fraction =  fraction >> 1;
        binDigits.unshift(remainder);
    }

    if (dec < 0) {
        binDigits.unshift("-");
    }

    return binDigits.join('');
}