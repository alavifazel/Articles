## Table of Contents

1.  [Root mean square](#root-mean-square)
    1.  [When do we use rms?](#when-do-we-use-rms)

<a id="root-mean-square"></a>

## Root mean square

Root mean square for a set of discrete numbers, which is commonly called
by it's abbreviation **rms** is defined as:

$$
X_{rms} = \sqrt{\frac{1}{n}(x_1^2 + x_2^2 + x_3^2 + ... + x_n^2 )}
$$

**ex.** Calculate the *rms* of numbers \(4\), \(5\), \(2\) and \(7\).

**ans.**
$$
X_{rms} = \sqrt{\frac{1}{4}(4^2 + 5^2 + 2^2 + 7^2)} \approx 4.847
$$

We've seen the definition of *rms* for the cases that we have some
discrete numbers. If we had a continuous function instead, we'd use the
following definition:

$$
f_{rms} = \sqrt{\frac{1}{T_2 - T_1} \int_{T_1}^{T_2} [f(dx)]^2 dx }
$$

**ex.** Calculate the *rms* of function \(f(x) = x^3\) from \(x = 1\) to
\(x = 4\).

**ans.** Plugging it into formula:

$$
f_{rms} = \sqrt{\frac{1}{1 - 4} \int_{1}^{4} [x^3]^2 dx } \approx 27.9
$$

<a id="when-do-we-use-rms"></a>

### When do we use rms?

When the source of electrical power in not a fixed DC value and it's
alternating over time, how would we calculate the *average power*
consumed by a resistive element? From the formula of power we have:

$$
P(t) = I(t).V(t)
$$

We also know from Ohm's law that $I(t) = \frac{V(t)}{R}$, therefore
substituting it into the formula we get:

$$
P(t) = \frac{V(t)^2}{R}
$$

This formula gives the power at each point in time. Since \(V(t)\) is
alternating, the power varies over time as well and doesn't have a fixed
value. So to calculate the *average* power we should use integral for
this.

$$
P_{avg} = \frac{1}{R}.\frac{\int_{T_0}^{T_1} V(t)^2 dt }{T_1 - T_0}
$$

This is all we need for calculating the average power. However if we
take the integral term (with it's denominator \(T_1 - T_0\)) and take it's
square root, it turns into the *rms* value we defined earlier.

$$
V_{rms} = \sqrt{\frac{\int_{T_0}^{T_1} V(t)^2 dt }{T_1 - T_0}}
$$

Now by having this value, to calculate the average power we should
reverse the effect of taking the square root by raise it to power of \(2\)
(and division by resistivity \(R\)):

$$
P_{avg} = \frac{V^2_{rms}}{R}
$$

Why do we take the square root of an expression just to raise it to the
power of \(2\) later? Because if we somehow know the \(V_{rms}\) of an AC
signal, we would use the *same* formula for calculating average power as
if we had a fixed DC voltage over time $(P_{avg} = \frac{V^2_{dc}}{R}$);
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

$$
V(t) = V_{Max} \sin(\omega t)
$$

Plugging it into the definition of *rms*,

$$
V_{rms} = \sqrt{\frac{\int_{T_0}^{T_1} (V_{Max} \sin \omega t) ^ 2 dt} {T_1 - T_0}}
$$

$V_{Max}$ is just a constant and goes out of the square root. So we get:

$$
V_{rms} = V_{Max} \sqrt{\frac{\int_{T_0}^{T_1} (\sin \omega t) ^ 2 dt }{T_1 - T_0}}
$$

We also know from basic properties of trigonometric functions:

$$
\sin^2 x = \frac{1 + \cos 2x}{2}
$$

Substituting the sine term with this property:

$$
V_{rms} = V_{Max} \sqrt{\frac{1}{{T_1 - T_0}}{\int_{T_0}^{T_1} \frac{1 + \sin \omega t dt}{2}}} = \\
$$$$
V_{Max} \sqrt{\frac{1}{T_1 - T_0} \left[ \frac{t}{2} - \frac{\sin 2 \omega t}{4 \omega}\right]_{T_0}^{T_1} }
$$

Now since the range \(T_0\) to \(T_1\) is one period of the sinusoidal
function, the sine integral is just \(0\). Therefore:

$$\begin{gathered}
    V_{rms} = V_{Max} \sqrt{\frac{1}{T_1 - T_0} \left[ \frac{t}{2} \right]_{T_0}^{T_1}} = \\
    V_{Max}\sqrt{\frac{1}{T_1 - T_0} . \frac{T_1 - T2}{2}} = \\
 V_{Max} \frac{1}{\sqrt{2}}
    \end{gathered}
$$

Which proves that for calculating the *rms* of a sinusoidal signal, we
can skip the integration process and simply divide its peak value by
$\sqrt{2}$.

# Epilogue
This article is licensed under Apache License 2.0.
Please view the *LICENSE* file for more info.
If you found any grammar or technical mistakes kindly send a pull request.
