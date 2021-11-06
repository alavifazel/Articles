
# Table of Contents

1.  [Root mean square](#root-mean-square)
    1.  [When do we use rms?](#when-do-we-use-rms)
2.  [Representing electrical signals in software](#representing-electrical-signals-in-software)
3.  [What's Next?](#whats-next)


<a id="root-mean-square"></a>

# Root mean square

Root mean square for a set of discrete numbers, which is commonly called
by it's abbreviation **rms** is defined as:

\[X_{rms} = \sqrt{\frac{1}{n}(x_1^2 + x_2^2 + x_3^2 + ... + x_n^2 )}\]

**ex.** Calculate the *rms* of numbers \(4\), \(5\), \(2\) and \(7\).

**ans.**
\[X_{rms} = \sqrt{\frac{1}{4}(4^2 + 5^2 + 2^2 + 7^2)} \approx 4.847\]

We've seen the definition of *rms* for the cases that we have some
discrete numbers. If we had a continuous function instead, we'd use the
following definition:

\[f_{rms} = \sqrt{\frac{1}{T_2 - T_1} \int_{T_1}^{T_2} [f(dx)]^2 dx }\]

**ex.** Calculate the *rms* of function \(f(x) = x^3\) from \(x = 1\) to
\(x = 4\).

**ans.** Plugging it into formula:

\[f_{rms} = \sqrt{\frac{1}{1 - 4} \int_{1}^{4} [x^3]^2 dx } \approx 27.9\]


<a id="when-do-we-use-rms"></a>

## When do we use rms?

When the source of electrical power in not a fixed DC value and it's
alternating over time, how would we calculate the *average power*
consumed by a resistive element? From the formula of power we have:

\[P(t) = I(t).V(t)\]

We also know from Ohm's law that \(I(t) = \frac{V(t)}{R}\), therefore
substituting it into the formula we get:

\[P(t) = \frac{V(t)^2}{R}\]

This formula gives the power at each point in time. Since \(V(t)\) is
alternating, the power varies over time as well and doesn't have a fixed
value. So to calculate the *average* power we should use integral for
this.

\[P_{avg} = \frac{1}{R}.\frac{\int_{T_0}^{T_1} V(t)^2 dt }{T_1 - T_0}\]

This is all we need for calculating the average power. However if we
take the integral term (with it's denominator \(T_1 - T_0\)) and take it's
square root, it turns into the *rms* value we defined earlier.

\[V_{rms} = \sqrt{\frac{\int_{T_0}^{T_1} V(t)^2 dt }{T_1 - T_0}}\]

Now by having this value, to calculate the average power we should
reverse the effect of taking the square root by raise it to power of \(2\)
(and division by resistivity \(R\)):

\[P_{avg} = \frac{V^2_{rms}}{R}\]

Why do we take the square root of an expression just to raise it to the
power of \(2\) later? Because if we somehow know the \(V_{rms}\) of an AC
signal, we would use the *same* formula for calculating average power as
if we had a fixed DC voltage over time (\(P_{avg} = \frac{V^2_{dc}}{R}\));
Namely raising it to power of \(2\) then dividing it by \(R\). So *rms*
value of a voltage or current is a convenient way to describe an AC
signal besides its peak value and frequency that we would normally do.

When we're speaking about AC signals, we are most likely dealing with
*Sinusoidal* AC signals. So let's investigate and see if the *rms* of a
general sinusoidal AC signal yields anything constant. If so, then we'd
omit the whole integration process every time we want to calculate the
*rms* of a sinusoidal signal and simply multiply that constant by some
term.

General sinusoidal function has the following form in one cycle:

\[V(t) = V_{Max} \sin(\omega t)\]

Plugging it into the definition of *rms*,

\[V_{rms} = \sqrt{\frac{\int_{T_0}^{T_1} (V_{Max} \sin \omega t) ^ 2 dt} {T_1 - T_0}}\]

\(V_{Max}\) is just a constant and goes out of the square root. So we get:

\[V_{rms} = V_{Max} \sqrt{\frac{\int_{T_0}^{T_1} (\sin \omega t) ^ 2 dt }{T_1 - T_0}}\]

We also know from basic properties of trigonometric functions:

\[\sin^2 x = \frac{1 + \cos 2x}{2}\]

Substituting the sine term with this property:

\[\begin{aligned}
    V_{rms} = V_{Max} \sqrt{\frac{1}{{T_1 - T_0}}{\int_{T_0}^{T_1} \frac{1 + \sin \omega t dt}{2}}} = \\
     V_{Max} \sqrt{\frac{1}{T_1 - T_0} \left[ \frac{t}{2} - \frac{\sin 2 \omega t}{4 \omega}\right]_{T_0}^{T_1} }
    \end{aligned}\]

Now since the range \(T_0\) to \(T_1\) is one period of the sinusoidal
function, the sine integral is just \(0\). Therefore:

\[\begin{gathered}
    V_{rms} = V_{Max} \sqrt{\frac{1}{T_1 - T_0} \left[ \frac{t}{2} \right]_{T_0}^{T_1}} = \\
    V_{Max}\sqrt{\frac{1}{T_1 - T_0} . \frac{T_1 - T2}{2}} = \\
 V_{Max} \frac{1}{\sqrt{2}}
    \end{gathered}\]

Which proves that for calculating the *rms* of a sinusoidal signal, we
can skip the integration process and simply divide its peak value by
\(\sqrt{2}\).


<a id="representing-electrical-signals-in-software"></a>

# Representing electrical signals in software

Before continuing with the more advanced EE concepts, let's implement
the ideas we discussed so far in form of a software package. We would
therefore use these implementations readily in the future articles and
projects as well. We use the C++ language to write these constructs
since it is widely used in microcontroller and system programming; And
also supports advanced language features and paradigms.

One of the fundamental concepts that we would want to implement, is a
construct that would represent an *electrical signal* in our programs.
This idea can be implemented conveniently with OOP<sup><a id="fnr.1" class="footref" href="#fn.1">1</a></sup> paradigm; i.e.
if we have a *class* that represents the type of a signal in our
program, instantiating it with:

    Signal s(<function_body>);

Would capture the signal's function, and with the appropriate definition
of our class this instance \(s\) would readily contain all the frequently
used operations such as calculating its \(rms\) and etc. Hence:

    s.getRms()

Would return the function's *rms* or:

    s.fourierTransform()

Would apply Fourier transform on our signal (an important math operation
that we will discuss in later articles) and so on.

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

1.  We defined a type alias for a real-valued math function that have

real-valued inputs and outputs (\(\Re\rightarrow\Re\)). We called this
alias **rftype** for ***r\*eal-valued \*f\*unction \*type**.*

1.  We declared the member variable \(function\), as a protected member

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

This class is also straightforward. It's constructor accepts a function
and period in which the function would repeat after that point. Note
that in \(getRms\) we uses *numerical<sub>integration</sub>* for estimating the
definite integral. This function can be implemented in various ways. A
quick one is to use the trapezoidal method:

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

# What's Next?

In the follow up article, we will discuss some concepts behind AC
circuit analysis; Namely phasor diagrams and complex number
representation.

These documents are published under an open license (see the project's
root directory for more info), and were intended to be part of an open
and a collaborative project. Feel free to fork this document, send pull
request and also give your feedback. Thanks for reading!


# Footnotes

<sup><a id="fn.1" href="#fnr.1">1</a></sup> Object Oriented Programming
