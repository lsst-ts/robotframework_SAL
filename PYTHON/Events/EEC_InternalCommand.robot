*** Settings ***
Documentation    EEC_InternalCommand communications tests.
Force Tags    python    TSS-2724
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    eec
${component}    InternalCommand
${timeout}    30s

*** Test Cases ***
Verify Component Sender and Logger
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_${component}.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_${component}.py

Start Sender - Verify Missing Inputs Error
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Sender.
    ${input}=    Write    python ${subSystem}_Event_${component}.py 
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}   ERROR : Invalid or missing arguments : CommandObject priority

Start Logger
    [Tags]    functional
    Switch Connection    Logger
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Logger.
    ${input}=    Write    python ${subSystem}_EventLogger_${component}.py
    ${output}=    Read Until    logger ready
    Log    ${output}
    Should Contain    ${output}    ${subSystem}_${component} logger ready

Start Sender
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Sender.
    ${input}=    Write    python ${subSystem}_Event_${component}.py 147 179 67 88 9 0 195 108 146 228 65 59 145 185 155 229 68 69 139 116 190 10 48 42 87 125 101 5 254 230 176 233 22 108 67 250 89 221 224 91 71 253 78 244 159 77 112 245 173 106 40 108 243 74 74 229 144 161 201 11 178 105 160 107 8 221 65 75 113 14 153 242 255 106 255 70 198 192 238 154 226 196 90 160 98 5 183 17 111 84 35 181 239 19 44 77 157 8 48 168 155 34 248 248 178 70 93 152 171 165 32 174 247 143 202 247 71 208 91 130 242 56 139 225 61 75 220 227 39 249 177 38 204 81 162 32 210 103 132 202 45 243 119 161 241 27 251 5 215 181 226 37 157 233 35 219 53 241 51 11 49 214 224 165 77 40 221 7 106 126 203 93 173 78 60 243 56 92 228 203 137 77 229 255 150 165 111 121 97 149 81 21 104 89 209 156 33 122 222 124 191 180 152 6 8 139 197 39 38 88 159 70 17 44 0 151 126 236 26 176 140 167 37 195 186 174 243 85 130 173 251 137 61 206 36 6 130 25 141 166 136 88 50 100 241 228 25 5 28 241 172 228 111 47 108 61 112 220 166 144 65 196 206 200 35 160 231 243 14 173 147 133 202 94 166 187 20 214 27 170 134 250 30 7 122 15 211 226 239 157 80 201 202 174 51 73 96 183 149 105 35 51 44 39 198 72 96 70 89 43 42 211 69 153 213 77 202 101 72 135 72 228 112 166 6 48 106 32 94 96 172 163 114 120 94 116 121 6 95 213 150 143 71 203 215 26 245 125 142 93 201 152 199 22 174 84 233 239 255 224 193 165 248 101 24 80 63 27 98 136 71 249 17 244 144 85 239 181 34 177 61 176 51 129 220 39 183 225 207 149 143 240 221 174 37 127 193 6 164 58 159 36 209 121 242 70 247 25 63 206 70 111 114 189 169 119 121 230 49 158 151 236 209 197 228 102 118 235 183 82 85 97 155 29 58 85 217 85 247 63 24 148 180 14 127 108 30 211 175 255 16 123 137 144 104 128 236 64 108 153 225 185 56 204 85 96 220 24 236 246 75 132 234 159 141 12 3 176 172 55 128 214 179 237 83 200 123 84 254 52 245 75 118 39 170 68 197 195 115 79 72 181 117 175 199 221 163 41 200 204 14 40 251 197 117 115 240 154 226 203 156 159 35 58 151 119 64 153 36 158 255 148 174 45 0 111 177 160 245 96 245 132 42 21 220 1 85 59 54 92 226 232 92 128 49 19 165 16 179 173 64 183 108 8 93 160 67 59 219 217 226 55 57 163 218 50 254 65 80 45 250 114 79 215 216 104 249 115 249 181 195 146 19 103 181 14 160 254 15 111 78 202 126 150 46 53 103 170 74 189 82 6 255 91 126 21 208 16 68 183 90 254 172 223 25 13 143 178 151 123 54 35 48 227 27 215 67 165 200 58 223 87 138 177 47 208 34 132 250 223 178 68 146 229 212 164 84 150 14 147 142 158 4 189 20 70 223 27 161 158 79 4 173 49 116 86 75 123 64 212 110 60 194 161 38 168 144 212 180 160 65 147 255 45 213 142 133 238 62 132 209 239 121 129 41 7 143 170 6 222 9 85 102 176 239 216 2 91 41 128 66 88 149 193 243 169 58 94 120 189 4 230 244 201 67 161 125 57 253 70 96 23 225 33 61 81 87 163 65 32 48 48 125 243 194 145 232 122 182 57 247 41 36 55 153 107 212 174 59 10 130 145 109 143 241 190 204 47 73 123 59 128 64 106 232 35 52 71 145 228 10 211 229 162 48 172 177 75 159 76 131 140 219 159 123 226 184 103 225 13 48 192 123 115 190 210 77 175 254 176 157 160 248 22 54 252 154 204 180 131 124 147 188 42 191 150 181 5 78 36 206 213 92 188 89 93 179 147 176 234 117 255 68 43 114 10 212 118 100 182 29 44 8 23 179 149 235 113 145 94 11 112 56 69 147 52 11 236 196 231 169 166 96 48 81 234 119 70 171 45 191 179 6 35 242 240 65 112 63 6 184 50 219 140 107 46 174 236 97 36 200 63 91 188 42 234 182 130 64 26 95 118 59 107 142 171 91 22 223 150 224 175 150 31 204 179 219 96 20 191 187 233 173 0 6 139 68 215 63 78 135 214 200 161 127 92 12 55 3 159 10 219 203 19 195 113 237 2 91 168 97 132 60 115 10 120 118 160 133 61 219 186 246 255 105 225 150 223 191 215 66 131 75 32 12 60 210 46 92 30 -824806997
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] eec::logevent_InternalCommand writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
