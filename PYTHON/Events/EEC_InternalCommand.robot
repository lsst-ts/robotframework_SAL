*** Settings ***
Documentation    EEC_InternalCommand sender/logger tests.
Force Tags    python    
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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 108 232 71 9 194 145 192 94 252 117 80 193 76 202 5 97 24 207 32 32 210 206 4 189 180 7 241 92 84 229 249 17 149 163 126 67 59 183 242 50 116 48 50 181 141 132 109 254 254 165 62 74 213 180 245 142 208 84 111 207 219 76 53 9 59 17 32 73 62 124 23 239 1 225 69 122 166 119 47 125 172 171 165 143 20 58 107 184 172 22 174 108 91 242 222 18 253 172 79 52 247 234 227 5 134 223 225 123 34 245 180 155 225 41 132 150 100 229 5 123 151 110 212 4 22 228 143 246 218 122 113 28 91 121 14 199 224 255 176 203 6 119 219 103 189 145 161 104 186 12 154 225 85 231 181 231 210 161 140 181 18 177 100 244 252 249 122 178 0 17 119 222 246 57 162 117 97 180 48 154 144 174 105 219 239 203 161 167 22 168 84 99 177 196 210 102 46 248 45 178 173 4 186 104 226 103 128 203 120 0 186 85 216 192 19 24 223 78 246 138 175 186 202 25 39 113 247 221 59 39 149 56 102 255 203 223 217 127 189 9 64 127 93 160 119 204 65 196 226 114 31 109 17 42 162 104 74 59 239 208 107 87 140 100 203 157 195 124 215 146 56 30 236 11 105 146 94 69 133 215 113 15 167 31 90 255 229 26 197 44 13 21 166 194 167 250 179 246 139 31 228 81 8 135 240 181 44 100 21 27 92 140 209 52 255 36 125 151 243 125 75 159 47 116 63 31 180 206 17 27 80 41 255 130 179 159 146 239 209 56 15 57 72 26 176 66 46 68 172 254 20 195 95 111 26 129 83 3 1 43 37 235 100 2 213 94 25 41 62 59 100 202 39 170 5 238 220 25 254 233 220 118 122 40 188 166 135 200 41 246 161 230 100 135 148 77 65 187 199 41 101 238 123 166 136 8 168 199 142 108 209 123 254 126 237 95 79 53 177 214 121 31 13 169 6 225 121 0 206 42 230 236 138 7 36 144 195 110 134 154 192 160 253 41 26 13 30 132 163 154 125 76 102 132 144 217 236 154 212 127 165 170 231 180 126 153 47 79 171 10 247 237 92 80 14 215 148 80 155 79 185 116 139 128 180 120 194 137 24 31 32 170 177 118 20 244 12 132 83 154 45 171 73 41 106 9 199 163 104 120 66 198 239 126 140 131 241 243 8 122 77 184 152 79 65 121 45 186 244 154 37 154 245 44 235 208 242 10 144 38 6 234 207 217 202 33 192 139 135 181 186 10 139 98 171 160 21 105 212 132 57 18 211 236 86 112 157 13 103 201 22 0 81 222 174 23 190 55 224 53 129 229 145 27 205 92 21 40 61 88 187 21 253 238 153 213 200 249 250 224 92 227 229 191 16 47 188 237 63 154 64 113 8 166 204 224 1 159 254 104 72 231 223 151 140 88 107 192 239 218 77 193 82 236 205 109 67 60 44 99 245 209 176 226 40 220 52 121 169 1 124 158 3 218 210 23 155 77 73 73 37 230 20 137 51 202 31 204 140 107 226 127 51 173 121 197 114 125 62 80 134 111 13 174 196 89 94 103 147 179 30 194 211 64 190 208 192 123 120 143 8 34 162 149 69 98 151 166 153 127 125 99 20 79 53 40 232 178 62 196 227 40 41 121 213 128 142 249 97 27 91 16 248 129 132 113 249 140 181 136 58 224 224 210 229 39 24 115 122 75 71 94 146 31 25 88 144 215 252 207 229 207 38 205 212 234 14 45 1 22 95 244 227 152 24 24 151 139 225 126 123 145 247 222 224 79 54 181 29 197 212 149 206 212 6 34 9 153 117 204 3 46 155 112 24 251 47 94 210 103 188 96 91 252 171 31 212 84 220 5 212 153 148 85 158 172 47 137 94 254 25 78 100 215 86 166 104 65 166 95 80 48 166 197 75 216 192 59 11 247 10 27 0 255 152 27 64 192 119 31 238 100 78 38 5 200 39 241 184 235 126 37 50 227 135 162 103 134 20 176 0 232 62 195 23 138 192 179 211 239 52 64 30 12 139 170 148 172 233 12 62 226 116 21 250 43 81 147 125 114 61 31 200 225 144 125 38 233 119 193 117 58 141 128 232 103 240 36 249 106 121 219 76 151 164 145 151 160 186 244 212 238 106 161 210 42 139 190 46 60 208 140 204 93 160 17 51 95 97 57 1 8 239 144 162 101 5 124 61 2 142 197 155 100 66 109 30 202 6 195 0 115 193 57 153 230 182 106 227 58 130 30 93 96 166 145 107 73 167 141 -1340195890
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
