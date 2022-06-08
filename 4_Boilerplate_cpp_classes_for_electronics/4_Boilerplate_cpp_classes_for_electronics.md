<a id="representing-electrical-signals-in-software"></a>

## Representing electrical signals in software

Before continuing with the more advanced EE concepts, let's implement
the ideas we discussed so far in form of a software package. We would
therefore, use these implementations readily in the future articles and
projects. We use the C++ language to write these constructs
since it is widely used in electronics and microcontrollers programming; which also supports advanced language features and paradigms.

One of the fundamental concepts that we would want to implement, is a
construct that would represent an *electrical signal* in our programs.
This idea can be implemented conveniently with OOP[^1] paradigm; i.e.
if we have a *class* that represents the type of a signal in our
program, instantiating it with:

    Signal s(<function_body>);

Would capture the signal's function, and with the appropriate definition
of our class this instance\(s\) would readily contain all the frequently
used operations such as calculating its \(rms\) and etc. Hence:

    s.getRms()

Would return the function's *rms* or:

    s.fourierSeries()

Would calculate the Fourier series of our signal (an important math operation that we will discuss in later articles), and so on.

Let's start by defining the base class:

        #include <cmath>
        #include <functional>
    class Signal {
    protected:
        using rftype =  std::function<double(double)>;
        rftype function;
    public:
        Signal(rftype f): function(f) {}
        double output(double x) { return function(x); }
        rftype getFunction() {return function; }
    };

This class can be used as:

    Signal s([](double t) {return t*t;});
    std::cout << s.output(3) << '\n';
    std::cout << s.output(0.4) << '\n';

Running the program we get:

    9
    0.16

As we see, the object \(s\) can now represents a signal in our program.
For now, writing \(s.output(x)\) gives the signal's output at time \(x\) and
\(s.getFunction()\) returns the signal's function definition if we needed
somewhere in our program.

Few remarks here:

1.  We included the header **functional** to make the type *std::function*
available in our program. With this type we captured the function's body
in the constructor.

2.  We defined a type alias for a real-valued math function that have
real-valued inputs and outputs ($\Re\rightarrow\Re$). We called this
alias **rftype** for **real-valued function type**.

3.  We declared the member variable \(function\), as a protected member
because later on we want to derive more specific types of signal namely
DC, AC and Sinusoidal AC from this class.

Now let's move on to defining derived classes. The first one is for the
DC signals which has a straightforward definition.

    class DcSignal: public Signal {
    public:
        DcSignal(double dcValue): Signal([dcValue](double t) -> double {
            return dcValue;
        }){}
    };

It can be used as:

    DcSignal s(4);

For AC signal class:

    class AcSignal: public Signal {
    public:
        AcSignal(rftype func, double p): Signal([func,p](double t) -> double {
            if(std::abs(t) <= std::abs(p)) return func(t);
            else return func(t - (int)(t/p) * p);
        }), f(1/p), p(p){}

        double getRms() {
            return std::sqrt(1/p * numerical_integration(function, 0, p));
        }

        double getFrequency() { return f; }
        double getPeriod() { return p; }
    protected:
        double f, p;
    };

This class is also straightforward. Its constructor accepts a function and a period in which the function would repeat after that point.
Note that in *getRms* function, we use *numerical_integration* to calculate the definite integral.
This function can be implemented in various ways.
An easy-to-implement way is to use the trapezoidal method:

    double numerical_integration(std::function<double(double)> f,
                          double a, double b, double N = 10000) {
        double h = (b - a) / N;
        double tmp = 0;
        tmp += f(a);
        tmp += f(b);
        while(a < b) {
            tmp += 2 * f(a);
            a += h;
        }
        return (h/2)*tmp;
    }

Example usage of *AcSignal*:

    AcSignal s([](double t) {return t*t;}, 2);
    cout << s.output(0.5) << '\n';
    cout << s.output(2.5) << '\n';

Produces:

    0.25
    0.25

Now let's define a class that we'd likely use the most: Sinusoidal
signals. Since this class is a type of AC signal and it's periodic, we
derive it from the *AcSignal*.

    class SinusoidalAcSignal: public AcSignal {
    public:
        SinusoidalAcSignal(double amplitude, double frequency,
                           double phase = 0):
         AcSignal([amplitude, frequency, phase](double t) -> double {
         return amplitude * std::sin(t*2*3.14159268*frequency + phase);
        }, 1/frequency), a(amplitude) {}

        double getRms() { return a/std::sqrt(2); }

        double getAmplitude() { return a; }
    private:
        double a;
    };

(The definition of these classes are presented in a single file inside
this article's directory.)

We have now defined some boilerplate classes that we'd use in situations
such as when we want to generate some sinusoidal signal for an output
pin of a microcontroller. For another example when we want to simulate
an input signal for analyzing circuits with a software.


<a id="whats-next"></a>

[^1]: Object Oriented Programming

# Epilogue
This article is licensed under Apache License 2.0.
Please view the *LICENSE* file for more info.
If you found any grammar or technical mistakes kindly send a pull request.
