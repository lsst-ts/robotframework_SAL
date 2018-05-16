*** Settings ***
Documentation    EEC_InternalCommand sender/logger tests.
Force Tags    python    Checking if skipped: eec
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
    ${input}=    Write    python ${subSystem}_Event_${component}.py 201 49 61 38 29 7 202 147 162 7 108 230 68 87 52 180 57 30 31 104 28 61 223 161 136 195 140 252 198 175 188 35 150 252 180 103 17 88 47 181 161 147 184 240 169 149 123 10 55 252 223 2 95 47 48 103 164 7 158 247 43 96 27 161 7 84 212 232 22 50 172 170 140 188 32 199 185 106 209 201 225 149 138 44 31 40 180 47 38 254 52 57 55 93 130 63 191 150 1 63 36 229 130 63 127 9 96 146 187 179 235 24 34 114 90 14 65 251 100 189 171 208 23 46 93 180 28 80 255 89 231 42 67 195 168 196 198 174 144 39 114 154 133 254 209 3 164 93 26 29 193 234 194 71 129 57 126 181 109 227 143 173 194 162 12 116 150 141 94 180 161 217 55 138 49 141 57 190 238 71 142 149 87 39 99 23 224 61 1 209 104 218 105 150 214 22 154 244 134 61 215 104 104 33 183 64 5 184 174 34 43 223 220 203 122 87 98 171 109 112 253 231 73 11 155 228 225 106 110 55 135 91 241 84 100 25 132 16 63 246 221 49 10 168 253 185 100 208 190 75 145 122 6 190 23 186 235 107 0 64 74 132 18 105 41 103 154 137 52 175 29 194 132 47 12 112 120 254 224 42 249 141 199 132 114 125 190 84 83 27 241 212 185 145 208 145 216 234 46 232 108 5 13 0 117 167 144 212 114 55 171 67 130 251 144 25 241 115 62 230 100 75 134 165 83 42 206 165 124 210 214 182 106 163 219 35 102 182 43 165 106 238 27 59 159 226 189 154 7 31 220 119 244 127 186 176 226 176 32 12 95 123 146 100 37 216 75 126 248 159 7 122 232 50 56 96 34 74 134 26 2 221 193 80 208 5 21 163 180 80 157 167 180 109 146 76 77 130 252 90 18 126 248 64 201 143 109 118 89 132 154 151 28 164 204 175 52 75 171 68 64 196 217 95 208 84 163 138 161 105 215 200 81 198 117 111 227 41 124 110 220 232 156 65 43 194 161 1 90 218 85 254 226 218 217 199 31 205 34 101 172 113 249 243 130 127 106 113 205 250 132 227 24 43 138 234 196 99 11 60 103 86 109 40 140 200 138 113 40 107 225 96 139 249 24 190 173 34 37 44 24 45 116 109 43 119 108 183 73 53 144 179 15 179 230 8 26 157 90 95 106 29 232 119 224 11 14 245 217 215 44 30 147 99 202 74 113 174 46 71 103 169 5 180 106 208 54 82 221 183 53 139 206 207 131 180 134 189 227 59 225 190 100 126 109 127 23 121 168 153 250 87 3 92 78 45 95 82 170 160 172 177 107 211 27 137 115 182 37 251 212 43 43 239 253 34 3 224 28 243 147 125 225 241 164 241 163 22 58 50 90 180 177 48 190 139 33 71 185 117 75 166 203 59 83 216 33 208 150 236 61 20 21 203 113 37 221 142 164 249 25 44 130 250 144 76 133 226 135 200 188 204 246 221 249 169 184 75 111 247 138 223 31 13 186 214 172 120 129 207 32 231 209 94 102 91 33 152 208 188 236 141 221 134 182 4 1 89 45 162 110 30 113 171 45 198 37 2 181 127 172 50 73 125 169 151 121 159 223 160 179 56 43 100 143 194 58 150 23 109 230 251 95 31 94 90 194 219 235 137 61 207 114 203 149 220 175 199 67 181 227 128 160 178 205 92 17 161 64 119 178 34 122 227 212 106 72 226 95 52 233 166 221 66 100 124 48 219 85 202 241 212 255 146 2 3 122 131 105 131 81 126 91 186 26 227 91 101 177 255 37 224 221 239 100 206 49 111 5 3 207 65 4 185 53 154 142 19 126 168 173 119 214 229 183 102 100 91 137 118 201 47 79 159 114 37 237 228 230 32 94 155 81 76 61 128 164 139 31 199 246 92 46 88 201 64 53 125 236 236 23 124 11 74 83 35 132 127 194 15 207 165 13 206 30 170 63 39 84 242 239 14 160 173 89 123 146 238 56 234 121 69 231 201 72 89 208 46 218 244 4 3 183 46 41 240 143 99 238 37 158 129 203 47 148 151 13 225 138 29 104 91 167 122 251 5 106 143 237 36 192 250 140 34 115 171 40 62 36 102 185 49 70 50 250 199 119 38 244 178 165 128 71 207 127 111 13 130 91 2 62 26 206 237 179 196 232 32 34 134 139 136 41 24 179 229 140 240 125 187 55 247 224 57 244 228 42 139 123 101 230 49 232 190 147 88 60 16 116 194 119 132 67 37 96 131 57 248 84 120 446423758
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
