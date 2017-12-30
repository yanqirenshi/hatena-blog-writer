class LISP {
    constructor () {}

    find (item, array, test) {
        for (var i in array)
            if (test (array[i], item))
                return true;
        return false;
    }
}
