
module traffic_light (
    input clk,
    input reset,

    output reg ns_red,
    output reg ns_yellow,
    output reg ns_green,

    output reg ew_red,
    output reg ew_yellow,
    output reg ew_green
);

    // State declaration
    parameter S0 = 2'b00,
              S1 = 2'b01,
              S2 = 2'b10,
              S3 = 2'b11;

    reg [1:0] state;

    // State transition
    always @(posedge clk or posedge reset)
    begin
        if (reset)
            state <= S0;
        else
        begin
            case (state)

                S0: state <= S1;

                S1: state <= S2;

                S2: state <= S3;

                S3: state <= S0;

                default: state <= S0;

            endcase
        end
    end

    // Output logic
    always @(*)
    begin
        // Default outputs
        ns_red    = 0;
        ns_yellow = 0;
        ns_green  = 0;

        ew_red    = 0;
        ew_yellow = 0;
        ew_green  = 0;

        case (state)

            S0: begin
                ns_green = 1;
                ew_red   = 1;
            end

            S1: begin
                ns_yellow = 1;
                ew_red    = 1;
            end

            S2: begin
                ns_red   = 1;
                ew_green = 1;
            end

            S3: begin
                ns_red    = 1;
                ew_yellow = 1;
            end

            default: begin
                ns_red = 1;
                ew_red = 1;
            end

        endcase
    end

endmodule
