namespace Microsoft.Quantum.Samples.Chemistry.SimpleVQE {
    open Microsoft.Quantum.Core;
    open Microsoft.Quantum.Chemistry;
    open Microsoft.Quantum.Chemistry.JordanWigner;
    open Microsoft.Quantum.Chemistry.JordanWigner.VQE;
    open Microsoft.Quantum.Intrinsic;

    @EntryPoint()
    operation GetEnergyHydrogenVQE(theta1: Double, theta2: Double, theta3: Double, nSamples: Int) : Double {
        // Create a Hamiltonian to encode a Hydrogen molecule.
        let hamiltonian = JWOptimizedHTerms(
        [
            HTerm([0], [0.17120128499999998]),
            HTerm([1], [0.17120128499999998]),
            HTerm([2], [-0.222796536]),
            HTerm([3], [-0.222796536])],
        [
            HTerm([0, 1], [0.1686232915]),
            HTerm([0, 2], [0.12054614575]),
            HTerm([0, 3], [0.16586802525]),
            HTerm([1, 2], [0.16586802525]),
            HTerm([1, 3], [0.12054614575]),
            HTerm([2, 3], [0.1743495025])
        ],
        new HTerm[0],
        [
            HTerm([0, 1, 2, 3], [0.0, -0.0453218795, 0.0, 0.0453218795])
        ]
        );
        
        let inputState = (
            3,
            [
                JordanWignerInputState((theta1, 0.0), [2, 0]),
                JordanWignerInputState((theta2, 0.0), [3, 1]),
                JordanWignerInputState((theta3, 0.0), [2, 3, 1, 0]),
                JordanWignerInputState((1.0, 0.0), [0, 1])
            ]
        );
        
        let JWEncodedData = JordanWignerEncodingData(
            4,
            hamiltonian,
            inputState,
            -0.09883444600000002
        );

        let JWEncodedDataParam = JordanWignerEncodingData(
            5, hamiltonian, inputState, -0.09883444600000002
        );

return EstimateEnergy(
            JWEncodedDataParam, nSamples
        );
    }
}
