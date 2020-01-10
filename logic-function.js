
//const f1 = (d, c, b, a) => !a && !c && d || b && !c && !d || !a && b && !c || !a && b && d || a && c && !d || a && !b && c || a && !b && !d;

const f1 = (d, c, b, a) => {
    return (
        !d * !c * !b * !a + 
        // !d * !c * !b * a + 
        !d * !c * b * !a + 
        !d * !c * b * a + 
        // !d * c * !b * !a + 
        !d * c * !b * a + 
        !d * c * b * !a + 
        !d * c * b * a + 
        d * !c * !b * !a + 
        d * !c * !b * a
    ) ? 1 : 0;
}

const f2 = (d, c, b, a) => {
    return (a && c || b || d || !a && !c) ? 1 : 0;
}




// or(
//     and(!a, !c, d), 
//     and(b, !c, !d),
//     and(!a, b, d),
// )


const table = binTable(16) 

const res1 = table.map(vals => f1(...vals));
const res2 = table.map(vals => f2(...vals));

console.log(table)
console.log(res1)
console.log(res2)


for (let i = 0, I = table.length; i < I; i++) {
    console.log(`${i}: ${table[i].join(' ')}` )
}





function binTable(size) {
    const table = [];
    const padSize = (size - 1).toString(2).length;

    for (let i = 0; i < size; i++) {
        table.push(i.toString(2)
            .padStart(padSize, '0')
            .split('')
            .map(x => +x));
    }

    return table;
}