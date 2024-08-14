use std::process::Output;

fn main() {


    // In Rust, unlike in many imperative languages, most code constructs are expressions rather than statements.
    // This means they return a value rather than just perform an action.
    // This trait makes Rust more expressive, allowing functions, for example, to return values simply by stating an expression.
    // It underscores Rust's functional nature, making code concise and idiomatic.


    fn add_two1(x: u64) -> u64 {
        return x + 2;
    }

    fn add_two2(x: u64) -> u64 {
        x + 2
    }


    let mut x = 5;
    x = 6;



    let add_one = |x: i32| x + 1;
    println!("The result is: {}", add_one(5));


    let find_person: Option<&str> = Some("Alice");

    println!("{:?}", find_person);

    // Output: Some("Alice")


    enum Message {
        Quit,
        Move { x: i32, y: i32 },
        Write(String),
    }

    // Here, the enumeration Message is defined, which can be one of three kinds:

    // Quit — a simple variant, carrying no data.
    // Move — contains named fields x and y, both of type i32.
    // This variant is used to represent a movement message with two coordinates.

    // Write — contains a single unnamed field of type String.
    // This variant represents a message with text.


    let msg1 = Message::Write(String::from("hello"));

    let msg2 = Message::Move { x: 23, y: 12 };

    // Here, a variable `msg1` and `msg2` is created, which is assigned the value of
    // `Message::Write` with the string "hello" and
    // `Message::Move` with { x: 23, y: 12 } as an argument.
    // This demonstrates how instances of different enumeration variants can be created.

    match msg1 {
        Message::Quit => println!("The Quit variant"),
        Message::Move { x, y } => println!("Move in the x: {} and y: {}", x, y),
        Message::Write(text) => println!("Text message: {}", text),
    }

    // The `match` construct here is used for branching the program depending on the enum variant stored in `msg1` and `msg2`. `match` checks each variant:
    //
    //If `msg` is `Message::Quit`, a message about the Quit variant is printed.
    //If `msg` matches `Message::Move`, the fields `x` and `y` are extracted, and a message with these coordinates is printed.
    //If `msg` matches `Message::Write`, the `text` string is extracted, and a message with this text is printed.




    let pair = (2, -2);

    match pair {
        (x, y) if x == y => println!("Equal"),
        (x, 0) => println!("x axis: {}", x),
        (0, y) => println!("y axis: {}", y),
        _ => println!("Anywhere"),
    }



    // `apply_twice` takes a function and returns a new function that applies the original twice.
    fn apply_twice(f: fn(i32) -> i32) -> Box<dyn Fn(i32) -> i32> {
        Box::new(move |x| f(f(x)))
    }

    // `add_one` is a simple function that adds 1 to its input, showcasing function as a value.
    fn add_one(x: i32) -> i32 {
        x + 1
    }

    // Applying `add_one` twice through `apply_twice`, demonstrating higher-order functions.
    let double_add_one = apply_twice(add_one);
    println!("Result: {}", double_add_one(5));





    // Fn example: Closure that does not mutate state.
    let add_ten = |x: i32| x + 10;
    println!("add_ten: {}", add_ten(5));

    // FnMut example: Closure that mutates state.
    let mut counter = 0;
    let mut increment_counter = || {
        counter += 1; // Mutates the `counter` variable.
        counter
    };
    println!("increment_counter: {}", increment_counter());
    println!("increment_counter: {}", increment_counter());

    // FnOnce example: Closure that consumes captured variable.
    let text = "Hello".to_string();
    let consume_text = move || println!("consume_text: {}", text);
    consume_text();
    // `consume_text` cannot be used again after this point.



    // Output: Result: 7


    let vec = vec![1, 2, 3, 4];
    let iter = vec.iter();
    println!("vec: {:?}", vec);
    println!("iter: {:?}", iter);

    let squares: Vec<i32> = vec.iter().map(|&x| x * x).collect();
    println!("squares: {:?}", squares);

    let evens: Vec<i32> = vec.iter().filter(|&x| x % 2 == 0).cloned().collect();
    println!("evens: {:?}", evens);

    let sum: i32 = vec.iter().fold(0, |acc, x| acc + x);
    println!("sum: {}", sum);

    // vec: [1, 2, 3, 4]
    // iter: Iter([1, 2, 3, 4])
    // squares: [1, 4, 9, 16]
    // evens: [2, 4]
    // sum: 10


    enum Result<T, E> {
        Ok(T),
        Err(E),
    }

    fn divide(numerator: f64, denominator: f64) -> Result<f64, &'static str> {
        if denominator == 0.0 {
            Result::Err("Cannot divide by zero.")
        } else {
            Result::Ok(numerator / denominator)
        }
    }



    fn apply<F>(f: F) -> impl Fn(i32) -> i32
        where
            F: Fn(i32) -> i32,
    {
        move |x| f(x)
    }
    fn double(n: i32) -> i32 {
        n * 2
    }
    fn sqr(n: i32) -> i32 {
        n * n
    }

    println!("Apply sqr 6 : {}", apply(sqr)(6));
    println!("Apply double 2 : {}", apply(double)(2));

    // Apply sqr 6 : 36
    // Apply double 2 :4



    println!("---------------------------------------");


    let list = vec![3, 2, 6, 1, 8, 3, 12, 1];

    println!("unsorted list: {:?}", list);



    fn split_helper(sub_arr: &[i32]) -> (Vec<i32>, Vec<i32>) {
        match sub_arr {
            [] => (vec![], vec![]),
            [front, rest @ ..] => {
                let (half_one, half_two) = split_helper(rest);
                (half_two, std::iter::once(*front).chain(half_one.into_iter()).collect())
            }
        }
    }

    fn merge(left: Vec<i32>, right: Vec<i32>) -> Vec<i32> {
        match (left.as_slice(), right.as_slice()) {
            ([], []) => vec![],
            ([], right_slice) => right_slice.to_vec(),
            (left_slice, []) => left_slice.to_vec(),
            ([left_first, left_rest @ ..], [right_first, right_rest @ ..])
                if right_first >= left_first => {
                    [vec![*left_first], merge(left_rest.to_vec(), right.to_vec())].concat()
                }
            ([left_first, left_rest @ ..], [right_first, right_rest @ ..]) =>
                {
                    [vec![*right_first], merge(left.to_vec(), right_rest.to_vec())].concat()
                }
        }
    }

    // & indicates that the parameter is a reference, which means you are borrowing the array rather than taking ownership of it.
    // This is a common practice in Rust to avoid unnecessary data copying, promoting efficiency.
    fn merge_sort(arr: Vec<i32>) -> Vec<i32> {
        match arr.len() {
            0 => vec![],
            1 => arr,
            _ => {
                let (left, right) = split_helper(&arr);
                let left_sorted = merge_sort(left);
                let right_sorted = merge_sort(right);
                merge(left_sorted, right_sorted)
            }
        }
    }


    println!("Sorted list: {:?}", merge_sort(list));


}
