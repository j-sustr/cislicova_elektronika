

const vars = ['d', 'c', 'b', 'a']
const ones = [1,4,7,8,9,10,11,12,14,15]


let solution = solveQM(vars, ones);

function solveQM(vars, ones) {
    ones.sort((a, b) => a - b);
    let table = binTable(ones[ones.length - 1] + 1);

    table = table.filter((_, i) => ones.indexOf(i) !== -1);

    let tableA = Object.fromEntries(ones.map((x, i)=> [x, table[i]]));

    

}


console.log(Boolean(NaN))

//let table = binTable(10)
//table

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